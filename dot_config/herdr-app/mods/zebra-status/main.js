import { View, div, svg } from "gpui-kit";
import { h_flex } from "gpui-base";
import { spaces, agents, panes, theme, run, layout, shared, exec, watchFolder } from "herdr";

function find(node, id) {
  if (node?.id === id) return node;
  for (const child of node?.children ?? []) {
    const found = find(child, id);
    if (found) return found;
  }
  return null;
}

function where() {
  const space = spaces().find(s => s.active), tab = space?.tabs.find(t => t.active);
  return space && { cwd: panes().find(p => p.tab === tab?.id && p.cwd)?.cwd || space.folder, on: space.machine };
}

export default class WorkspaceStatus extends View {
  init(_props, cx) {
    this.last = null;
    cx.timer.every(60000, cx => { if (where()?.on) this.refresh(cx, true); });
  }

  refresh(cx, again = false) {
    const w = where(), key = JSON.stringify(w);
    if (!w?.cwd || (!again && key === this.key)) return;
    this.key = key;
    cx.spawn(async cx => {
      const r = await exec("git", ["log", "-1", "--format=%s"], { cwd: w.cwd, on: w.on }).catch(() => null);
      if (this.key !== key) return;
      this.last = r?.code === 0 ? r.stdout.trim() : null;
      cx.notify();
      if (!w.on && r?.code === 0) this.watch(w.cwd, cx);
    });
  }

  watch(cwd, cx) {
    cx.spawn(async cx => {
      const dir = (await exec("git", ["rev-parse", "--path-format=absolute", "--git-common-dir"], { cwd })).stdout.trim();
      if (this.watched === dir) return;
      this.watched = dir;
      while (this.watched === dir) {
        await watchFolder(dir);
        if (this.watched === dir && where()?.cwd === cwd) this.refresh(cx, true);
      }
    });
  }

  render(cx) {
    this.refresh(cx);
    const t = theme();
    const space = spaces().find(s => s.active);
    const list = agents();
    const count = st => list.filter(a => a.status === st).length;
    const label = (icon, text) => h_flex().gap(6).items_center().child(svg(`mods/workspace-chrome/${icon}.svg`).size(13)).child(text);
    const marks = [
      ["blocked", div().size(14).flex_none().rounded(4).bg(t.blocked + "26").text_size(10.5).font_bold().text_color(t.blocked).flex().items_center().justify_center().child("!")],
      ["working", svg("mods/workspace-chrome/spinner.svg").size(12).flex_none().text_color(t.working).spin(900)],
      ["done", div().size(7).flex_none().rounded(4).bg(t.done)],
      ["idle", div().size(7).flex_none().rounded(4).border(1.5).border_color(t.idle ?? t.dim)],
    ].filter(([st]) => count(st) > 0);
    const panel = find(layout(), "panel"), body = find(layout(), "panel-body");
    const enabled = shared("workspace.panels") ?? ["files", "changes"];
    const sidebarShown = !find(layout(), "sidebar")?.hidden;
    const toggle = (id, icon) => {
      const on = panel && !panel.hidden && body?.active === id;
      return div().id(`panel-${id}`).size(22).flex().items_center().justify_center().rounded(4)
        .text_color(on ? t.accent : t.muted).hover(s => s.bg(t.hover))
        .on_click(() => {
          if (on) run("layout.hide", { id: "panel" });
          else { run("layout.select", { stack: "panel-body", child: id }); run("layout.show", { id: "panel" }); }
        }).child(svg(icon).size(14));
    };
    return h_flex().size_full().pl(6).pr(14).gap(16).items_center().bg(t.chrome).border_t(1).border_color(t.border).text_size(12).text_color(t.muted)
      .child(h_flex().gap(2)
        .when(!sidebarShown, el => el.child(div().id("sidebar-show").size(22).flex().items_center().justify_center().rounded(4)
          .text_color(t.muted).hover(s => s.bg(t.hover))
          .on_click(() => run("layout.show", { id: "sidebar" })).child(svg("mods/zebra-status/icon/sidebar.svg").size(14))))
        .when(enabled.includes("files"), el => el.child(toggle("files", "mods/zebra-status/icon/file.svg")))
        .when(enabled.includes("changes"), el => el.child(toggle("changes", "mods/zebra-status/icon/changes.svg"))))
      .when(Boolean(space?.machine), el => el.child(label("server", space.machine)))
      .when(Boolean(space?.branch), el => el.child(label("branch", space.branch)))
      .when(Boolean(this.last), el => el.child(div().flex_1().min_w(0).truncate().text_color(t.dim).child(this.last)))
      .when(!this.last, el => el.child(div().flex_1()))
      .when(marks.length > 0, el => el.child(h_flex().id("agents").h(22).px(4).gap(10).items_center().rounded(4).cursor_pointer()
        .hover(s => s.bg(t.hover)).on_click(() => run("agent.next"))
        .children(marks.map(([st, mark]) => h_flex().gap(5).items_center().child(mark).child(String(count(st)))))));
  }
}
