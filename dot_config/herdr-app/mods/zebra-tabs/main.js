import { View, div, svg, image } from "gpui-kit";
import { h_flex } from "gpui-base";
import { spaces, panes, run, openOverlay, theme, window, shared, layout, updates } from "herdr";

function find(node, id) {
  if (node?.id === id) return node;
  for (const child of node?.children ?? []) {
    const found = find(child, id);
    if (found) return found;
  }
  return null;
}

export default class Tabs extends View {
  init() {
    this.pressed = null;
    this.hoveredTab = null;
    this.panels = JSON.parse(localStorage.getItem("panels") ?? "{}");
  }

  syncPanel(space, panel, body, enabled) {
    if (!space || !panel) return;
    const now = panel.hidden ? null : body?.active ?? null;
    if (space.id !== this.space) {
      const first = this.space === undefined;
      this.space = space.id; this.restoring = null;
      if (!(first && !(space.id in this.panels))) {
        const stored = this.panels[space.id] ?? null, want = enabled.includes(stored) ? stored : null;
        if (want !== now) {
          this.restoring = { want, until: Date.now() + 1000 };
          if (want) { run("layout.select", { stack: "panel-body", child: want }); run("layout.show", { id: "panel" }); }
          else run("layout.hide", { id: "panel" });
          return;
        }
      }
    }
    if (this.restoring) {
      if (this.restoring.want !== now && Date.now() < this.restoring.until) return;
      this.restoring = null;
    }
    if (this.panels[space.id] === now) return;
    this.panels[space.id] = now;
    localStorage.setItem("panels", JSON.stringify(this.panels));
  }

  render() {
    const t = theme();
    const space = spaces().find(p => p.active);
    const shown = space?.tabs ?? [];
    const stop = (_e, cx) => cx.stop_propagation();
    const button = (id, label, action) => div().id(id).size(22).flex_none().flex().items_center().justify_center().rounded(4).text_color(t.muted).hover(s => s.bg(t.hover))
      .on_mouse_down("left", stop).on_click(action).child(label);
    const item = (c, i) => {
      const program = panes().find(p => p.tab === c.id && p.program?.agent)?.program ?? panes().find(p => p.tab === c.id)?.program;
      const name = /^tb\d+$/.test(c.name) ? program?.name ?? "Terminal" : c.name;
      return h_flex().id(`tab-${c.id}`).on_hover((h, cx) => { this.hoveredTab = h ? c.id : this.hoveredTab === c.id ? null : this.hoveredTab; cx.notify(); }).h_full().px(12).gap(7).items_center().flex_none().text_size(12.8)
        .border_r(1).border_color(t.border).when(!c.active, el => el.border_b(1).hover(s => s.bg(t.hover)))
        .bg(c.active ? t.background : t.chrome).text_color(c.active ? t.foreground : t.muted)
        .on_mouse_down("left", (e, cx) => { cx.stop_propagation(); this.pressed = i; if (e.click_count === 2) run("tab.rename", { id: c.id }); })
        .on_mouse_up("left", () => {
          const from = this.pressed; this.pressed = null;
          if (from !== null && from !== i) run("tab.move", { id: shown[from].id, index: space.tabs.findIndex(x => x.id === c.id) + 1 });
          else run("tab.select", { id: c.id });
        })
        .on_mouse_down("right", () => openOverlay({ mod: "menu", kind: "popup", width: 200, props: { tab: "tab", target: { id: c.id, space: space.id } } }))
        .when(Boolean(program?.icon), el => el.child(program.tint ? svg(program.icon).size(14).text_color(t.muted) : image(program.icon).size(14)))
        .child(div().max_w(170).truncate().child(c.zoomed ? `${name} Z` : name))
        .when(c.status === "working", el => el.child(this.hoveredTab === c.id ? div().size(12).flex_none() : svg("mods/workspace-chrome/spinner.svg").size(12).flex_none().text_color(t.working).spin(900)))
        .when(c.status === "blocked" || c.status === "done", el => el.child(div().size(6).rounded(3).when(this.hoveredTab !== c.id, el => el.bg(t[c.status]))))
        .when(this.hoveredTab === c.id, el => el.relative().child(h_flex().absolute().top(0).right(0).h_full().pl(4).pr(8).items_center().bg(c.active ? t.background : t.hover)
          .child(div().id(`close-${c.id}`).size(16).flex().items_center().justify_center().rounded(4).text_color(t.muted).hover(s => s.bg(t.foreground + "1a"))
            .on_mouse_down("left", stop).on_click((_e, cx) => { cx.stop_propagation(); run("tab.close", { id: c.id }); })
            .child(svg("mods/pane/close.svg").size(12)))));
    };
    const panel = find(layout(), "panel"), body = find(layout(), "panel-body");
    const enabled = shared("workspace.panels") ?? ["files", "changes"];
    this.syncPanel(space, panel, body, enabled);
    const sidebarHidden = find(layout(), "sidebar")?.hidden;
    return h_flex().size_full().min_w(0).items_center().bg(t.chrome)
      .when(sidebarHidden, el => el.child(h_flex().h_full().flex_none().pl(window()?.platform === "macos" ? 76 : 6).pr(6).items_center().border_b(1).border_r(1).border_color(t.border)
        .child(h_flex().id("space-switch").h(24).px(6).items_center().rounded(4).cursor_pointer().text_size(12.8).text_color(t.foreground)
          .hover(s => s.bg(t.hover)).on_mouse_down("left", stop).on_click(() => run("mod.open", { name: "picker" }))
          .child(div().max_w(160).truncate().child(space?.name ?? "")))))
      .on_mouse_up("left", () => { this.pressed = null; })
      .on_scroll_wheel(e => { if (Math.abs(e.delta.y) >= 1) run(e.delta.y > 0 ? "tab.prev" : "tab.next"); })
      .child(h_flex().id("tab-scroll").flex_1().min_w(0).h_full().overflow_x_scrollbar().children(shown.map(item))
        .child(h_flex().h_full().flex_none().px(5).items_center().border_b(1).border_color(t.border)
          .child(button("tab-new", svg("mods/zebra-tabs/icon/plus.svg").size(14), () => openOverlay({ mod: "new-menu", kind: "popup", width: 250, height: 512 }))))
        .child(div().h_full().flex_1().min_w(0).border_b(1).border_color(t.border)))
      .child(h_flex().h_full().px(6).gap(2).items_center().border_b(1).border_color(t.border)
        .child(div().relative().child(button("settings", svg("mods/zebra-tabs/icon/settings.svg").size(14), () => run("app.settings")))
          .when(Boolean(updates().app.ready), el => el.child(div().absolute().top(4).right(4).size(5).rounded_full().bg(t.accent)))))
      .when(window()?.buttons, el => el.child(button("minimize", "−", () => run("window.minimize")))
        .child(button("maximize", "□", () => run("window.maximize")))
        .child(button("close-window", svg("mods/pane/close.svg").size(13), () => run("window.close"))));
  }
}
