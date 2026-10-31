import { View, div, svg, image } from "gpui-kit";
import { v_flex, h_flex } from "gpui-base";
import { spaces, agents, terminals, panes, focused, run, openOverlay, setAgentOrder, shared, setShared, theme } from "herdr";
import Git, { where } from "./git.js";

const icon = (name, size, color) => svg(`mods/zebra-sidebar/icon/${name}.svg`).size(size).flex_none().text_color(color);
function status(t, s, compact = false) {
  if (s === "working") return svg("mods/workspace-chrome/spinner.svg").size(12).mx(1).flex_none().text_color(t.working).spin(900);
  if (s === "blocked" && compact) return div().size(14).flex_none().rounded(4).bg(t.blocked + "26").text_size(10.5).font_bold().text_color(t.blocked).flex().items_center().justify_center().child("!");
  if (s === "blocked") return div().flex_none().px(6).h(18).rounded(4).bg(t.blocked + "26").text_size(10.5).font_semibold().text_color(t.blocked).flex().items_center().child("Needs you");
  if (s === "done") return div().size(7).mx(3).flex_none().rounded(4).bg(t.done);
  return null;
}
const programIcon = (t, p) => !p?.icon ? div().w(14).flex_none()
  : p.tint ? svg(p.icon).size(14).flex_none().text_color(t.muted) : image(p.icon).size(14).flex_none();
const MARK = { ansi6: "#22a99a", ansi3: "#e3814f", ansi4: "#5b8def", ansi5: "#8b7cf6", ansi2: "#3fae6a", ansi1: "#d9649a" };
const PALETTE = ["ansi6", "ansi3", "ansi4", "ansi5", "ansi2", "ansi1"];
const RANK = { blocked: 4, done: 3, working: 2, idle: 1 };
const SECTION = { 4: ["Needs you", "blocked"], 3: ["Done", "done"], 2: ["Working", "working"], 1: ["Idle", "dim"] };
const clean = s => (s ?? "").replace(/^[^\p{L}\p{N}~/.]+/u, "");
const kidStatus = (k, listed) => {
  const s = listed.get(k.address) ?? k.status;
  return s === "error" ? "blocked" : s === "done" ? "idle" : s;
};

function ago(ms) {
  const s = (Date.now() - ms) / 1000;
  if (s < 60) return "now";
  if (s < 3600) return `${Math.floor(s / 60)}m`;
  if (s < 86400) return `${Math.floor(s / 3600)}h`;
  if (s < 86400 * 30) return `${Math.floor(s / 86400)}d`;
  if (s < 86400 * 365) return `${Math.floor(s / 86400 / 30)}mo`;
  return `${Math.floor(s / 86400 / 365)}y`;
}

export default class Sidebar extends View {
  init(_props, cx) {
    this.git = new Git(cx);
    this.collapsed = new Set(JSON.parse(localStorage.getItem("collapsed") ?? "[]"));
    this.folded = new Set(JSON.parse(localStorage.getItem("machines.folded") ?? "[]"));
    this.pins = JSON.parse(localStorage.getItem("pins") ?? "[]");
    this.hovered = null; this.hoveredRow = null; this.pressed = null; this.over = null;
    this.shown = new Set(spaces().map(s => s.id)); this.born = {};
    cx.timer.every(30000, cx => cx.notify());
  }

  remember(set, key, id, cx) {
    if (set.has(id)) set.delete(id); else set.add(id);
    localStorage.setItem(key, JSON.stringify([...set]));
    cx.notify();
  }

  setPins(pins) {
    this.pins = pins;
    localStorage.setItem("pins", JSON.stringify(pins));
  }

  prunePins(all) {
    const machine = addr => (addr.includes("/") ? addr.split("/")[0] : "");
    const heard = new Set(all.map(k => machine(k.address)));
    const live = new Set(all.filter(k => k.state === "live").map(k => k.address));
    const kept = this.pins.filter(p => !heard.has(machine(p)) || live.has(p));
    if (kept.length !== this.pins.length) this.setPins(kept);
  }

  tree(all, addr, lead = []) {
    const kids = all.filter(k => k.parent === addr && k.state === "live");
    return kids.flatMap((k, i) => {
      const last = i === kids.length - 1;
      return [{ k, lines: [...lead, last ? "└" : "├"] }, ...this.tree(all, k.address, [...lead, last ? "" : "│"])];
    });
  }

  action(t, id, name, onClick) {
    return div().id(id).size(20).flex_none().flex().items_center().justify_center().rounded(4).hover(s => s.bg(t.foreground + "1a"))
      .on_mouse_down("left", (_e, cx) => cx.stop_propagation())
      .on_click((_e, cx) => { cx.stop_propagation(); onClick(cx); })
      .child(icon(name, 14, t.muted));
  }

  ordered(ps) {
    const sp = spaces();
    for (const s of sp) if (!this.shown.has(s.id) && (where(s, ps) in this.git.info || Date.now() - (this.born[s.id] ??= Date.now()) > 1500)) this.shown.add(s.id);
    const list = sp.map((s, i) => ({ s, i, g: this.git.of(s, ps) })).filter(r => this.shown.has(r.s.id));
    const mains = new Set(list.filter(r => r.g && !r.g.linked).map(r => r.g.repo));
    const nested = r => r.g?.linked && mains.has(r.g.repo);
    const out = [], placed = new Set();
    for (const r of list) {
      if (nested(r)) continue;
      out.push({ ...r, tree: false });
      if (!r.g || r.g.linked || placed.has(r.g.repo)) continue;
      placed.add(r.g.repo);
      for (const k of list) if (nested(k) && k.g.repo === r.g.repo) out.push({ ...k, tree: true });
    }
    return out;
  }

  gitTail(t, g, tree, name) {
    const raw = g.branch ?? "detached", same = a => a.toLowerCase() === name.toLowerCase();
    const branch = same(raw) || raw === "master" || raw === "main" ? "" : raw;
    const repo = tree || same(g.name) ? "" : g.name;
    const at = [repo, branch].filter(Boolean).join(" · ");
    return h_flex().flex_1().min_w(0).gap(5).justify_end().items_center().text_size(11.5).text_color(t.dim)
      .when(Boolean(at), el => el.child(div().min_w(0).truncate().child(at)))
      .when(g.ahead > 0, el => el.child(div().flex_none().text_color(t.ansi2).child(`↑${g.ahead}`)))
      .when(g.behind > 0, el => el.child(div().flex_none().text_color(t.ansi1).child(`↓${g.behind}`)));
  }

  header(t, { s, i, g, tree }) {
    const id = s.id, collapsed = this.collapsed.has(id), hovered = this.hovered === id;
    const top = s.tabs.reduce((m, x) => (RANK[x.status] ?? 0) > (RANK[m] ?? 0) ? x.status : m, null);
    const color = (shared("space.colors") ?? {})[id] ?? "ansi6", fill = color.startsWith("#") ? color : MARK[color] ?? t[color];
    return h_flex().id(`space-${id}`).h(32).px(10).gap(8).items_center().cursor_pointer().hover(st => st.bg(t.hover))
      .when(tree, el => el.pl(20))
      .when(this.pressed !== null && this.over === i && this.pressed !== i, el => el.border_t(2).border_color(t.accent))
      .on_hover((h, cx) => { this.hovered = h ? id : this.hovered === id ? null : this.hovered; if (h && this.pressed !== null) this.over = i; cx.notify(); })
      .on_mouse_down("left", () => { this.pressed = i; this.over = i; })
      .on_mouse_up("left", (_e, cx) => {
        const from = this.pressed; this.pressed = null;
        if (from !== null && from !== i) run("space.move", { id: spaces()[from].id, index: i + 1 });
        else this.remember(this.collapsed, "collapsed", id, cx);
        cx.notify();
      })
      .on_mouse_down("right", () => openOverlay({ mod: "menu", kind: "popup", width: 200, height: 260, props: { tab: "space", target: { id } } }))
      .child(tree ? icon("branch", 13, t.dim)
        : h_flex().size(16).flex_none().rounded(4).bg(fill).items_center().justify_center().text_size(10).font_bold().text_color("#ffffff").child(s.name[0]?.toUpperCase() ?? "?"))
      .child(div().min_w(0).max_w(140).truncate().text_color(t.foreground).child(s.name))
      .child(g && !hovered ? this.gitTail(t, g, tree, s.name) : div().flex_1())
      .when(collapsed && !hovered && top !== "idle" && Boolean(top), el => el.child(status(t, top, true)))
      .when(hovered, el => el
        .child(icon(collapsed ? "chevron-right" : "chevron-down", 12, t.dim))
        .child(this.action(t, `new-${id}`, "plus", () => { run("space.select", { id }); openOverlay({ mod: "new-menu", kind: "popup", width: 250, height: 512 }); })));
  }

  row(t, { id, program, title, detail, state, compact, time, selected, pin, onClick, onRight }) {
    const hovered = this.hoveredRow === id, pinned = pin && this.pins.includes(pin);
    return v_flex().id(id).w_full().py(4).px(10).cursor_pointer()
      .when(selected, el => el.bg(t.selected)).hover(st => st.bg(selected ? t.selected : t.hover))
      .on_hover((h, cx) => { this.hoveredRow = h ? id : this.hoveredRow === id ? null : this.hoveredRow; cx.notify(); })
      .on_click(onClick)
      .when(Boolean(onRight), el => el.on_mouse_down("right", onRight))
      .child(h_flex().h(24).gap(8).items_center()
        .child(h_flex().flex_1().min_w(0).gap(6).items_center()
          .child(programIcon(t, program))
          .child(div().min_w(0).truncate().text_color(selected ? t.foreground : t.muted).when(Boolean(detail), el => el.flex_shrink(0).max_w(110)).when(!detail, el => el.flex_1()).child(title))
          .when(Boolean(detail), el => el.child(div().flex_1().min_w(0).truncate().text_color(t.dim).child(`· ${detail}`))))
        .when(hovered && Boolean(pin), el => el.child(this.action(t, `pin-${id}`, pinned ? "pin-off" : "pin", cx => {
          this.setPins(pinned ? this.pins.filter(p => p !== pin) : [...this.pins, pin]);
          this.hoveredRow = null;
          cx.notify();
        })))
        .when(!(hovered && pin) && Boolean(status(t, state)), el => el.child(status(t, state, compact))))
      .when(Boolean(time), el => el.child(h_flex().gap(6).items_center()
        .child(div().w(14).flex_none())
        .child(div().text_size(12).text_color(t.dim).child(ago(time)))));
  }

  kids(t, all, addr, listed, shown) {
    return this.tree(all, addr).map(({ k, lines }) => {
      const on = k.address === shown;
      return h_flex().id(`sub-${k.address}`).h(24).pl(16).pr(10).items_center().cursor_pointer().text_size(12.5)
        .when(on, el => el.bg(t.selected)).hover(st => st.bg(on ? t.selected : t.hover))
        .on_click(() => run("terminal.peek", { terminal: k.address }))
        .children(lines.map(l => div().self_start().mt(-4).w(9).h(16).mr(4).flex_none()
          .when(Boolean(l), el => el.border_l(1.5).border_color(t.input))
          .when(l === "└" || l === "├", el => el.border_b(1.5).rounded_bl(4))))
        .child(div().mr(6).child(programIcon(t, k.program)))
        .child(div().flex_1().min_w(0).truncate().text_color(on ? t.foreground : t.muted).child(k.name || k.template || k.program?.name || k.address))
        .child(status(t, kidStatus(k, listed), true) ?? div());
    });
  }

  agentRow(t, a, ctx, compact = false) {
    const tab = ctx.tabs.get(a.tab);
    return [this.row(t, {
      id: `agent-${a.address}`, program: a.program, title: a.space_name, detail: clean(a.title) || a.program?.name,
      state: a.status, compact, time: tab?.changed_at, selected: a.focused, pin: a.address,
      onClick: () => run("pane.focus", { pane: a.pane }),
    }), ...this.kids(t, ctx.all, a.address, ctx.listed, ctx.shown)];
  }

  thread(t, space, tab, ctx) {
    const own = ctx.ps.filter(p => p.tab === tab.id && p.terminal);
    const mine = ctx.list.filter(a => a.tab === tab.id), agent = mine[0], first = own[0];
    const program = agent?.program ?? first?.program;
    const title = clean(agent?.title || (tab.named ? tab.name : first?.title || program?.name)) || `Tab ${tab.index}`;
    return [this.row(t, {
      id: `thread-${tab.id}`, program, title, state: tab.status, time: tab.changed_at,
      selected: space.active && tab.active, pin: agent?.address,
      onClick: () => { run("space.select", { id: space.id }); run("tab.select", { id: tab.id }); },
      onRight: () => openOverlay({ mod: "menu", kind: "popup", width: 200, props: { tab: "tab", target: { id: tab.id, space: space.id } } }),
    }), ...mine.flatMap(a => this.kids(t, ctx.all, a.address, ctx.listed, ctx.shown))];
  }

  section(t, id, label, color, rows) {
    return v_flex().border_b(1).border_color(t.border)
      .child(h_flex().id(id).h(28).px(10).items_center().text_size(11.5).text_color(t[color] ?? t.dim).child(label))
      .children(rows);
  }

  machine(t, m) {
    const known = this.git.machines.find(k => k.name === m), connected = !m || known?.state === "connected", folded = this.folded.has(m);
    return h_flex().id(`machine-${m ?? "local"}`).h(28).px(10).gap(7).items_center().text_size(11.5).text_color(t.dim)
      .cursor_pointer().hover(s => s.bg(t.hover)).border_b(1).border_color(t.border)
      .on_click((_e, cx) => this.remember(this.folded, "machines.folded", m, cx))
      .child(icon(m ? "server" : "monitor", 13, t.dim))
      .child(div().flex_1().truncate().child(m ?? "This computer"))
      .when(!connected, el => el.child(div().flex_none().child((known?.state ?? "asleep").replace(/_/g, " "))))
      .when(connected, el => el.child(this.action(t, `machine-new-${m ?? "local"}`, "plus", () => run("space.new", m ? { machine: m } : {}))))
      .child(div().size(6).rounded(3).flex_none().bg(connected ? t.ansi2 : t.dim))
      .child(icon(`chevron-${folded ? "right" : "down"}`, 11, t.dim));
  }

  colors() {
    const sp = spaces(), ids = new Set(sp.map(s => s.id)), all = shared("space.colors") ?? {};
    const kept = Object.fromEntries(Object.entries(all).filter(([id]) => ids.has(id)));
    let changed = Object.keys(kept).length !== Object.keys(all).length;
    for (const s of sp) {
      if (kept[s.id] || s.name === "~") continue;
      const uses = c => Object.values(kept).filter(v => v === c).length;
      kept[s.id] = PALETTE.reduce((best, c) => uses(c) < uses(best) ? c : best);
      changed = true;
    }
    if (changed) setShared("space.colors", kept);
  }

  grouped(t, ctx, pinned) {
    const rows = this.ordered(ctx.ps), order = [];
    const group = r => {
      const open = !this.collapsed.has(r.s.id);
      const tabs = r.s.tabs.filter(tab => !ctx.list.some(a => a.tab === tab.id && pinned.includes(a)));
      if (open) for (const tab of tabs) order.push(...ctx.list.filter(a => a.tab === tab.id).map(a => a.address));
      return v_flex().border_b(1).border_color(t.border).child(this.header(t, r))
        .when(open, el => el.children(tabs.flatMap(tab => this.thread(t, r.s, tab, ctx))));
    };
    const remote = [...new Set([...rows.map(r => r.s.machine).filter(Boolean), ...this.git.machines.map(m => m.name)])].sort();
    const items = !remote.length ? rows.map(group)
      : [null, ...remote].flatMap(m => [this.machine(t, m), ...(this.folded.has(m) ? [] : rows.filter(r => (r.s.machine ?? null) === m).map(group))]);
    return { items, order };
  }

  priority(t, ctx, pinned) {
    const urgency = a => Math.max(RANK[a.status] ?? 0, ...this.tree(ctx.all, a.address).map(({ k }) => RANK[kidStatus(k, ctx.listed)] ?? 0));
    const rest = ctx.list.filter(a => !pinned.includes(a))
      .sort((x, y) => urgency(y) - urgency(x) || (ctx.tabs.get(y.tab)?.changed_at ?? 0) - (ctx.tabs.get(x.tab)?.changed_at ?? 0) || y.seq - x.seq);
    const items = [4, 3, 2, 1].map(r => [r, rest.filter(a => (urgency(a) || 1) === r)]).filter(([, m]) => m.length)
      .map(([r, members]) => this.section(t, `sec-${r}`, `${SECTION[r][0]} ${members.length}`, SECTION[r][1], members.flatMap(a => this.agentRow(t, a, ctx, true))));
    return { items, order: rest.map(a => a.address) };
  }

  render() {
    this.colors();
    const t = theme(), all = terminals(), list = agents();
    const ctx = { all, list, ps: panes(), shown: focused()?.agent, listed: new Map(list.map(a => [a.address, a.status])),
      tabs: new Map(spaces().flatMap(s => s.tabs).map(tab => [tab.id, tab])) };
    this.prunePins(all);
    const pinned = this.pins.map(p => list.find(a => a.address === p)).filter(Boolean);
    const view = shared("zebra.sort") === "priority" ? this.priority(t, ctx, pinned) : this.grouped(t, ctx, pinned);
    setAgentOrder([...pinned.map(a => a.address), ...view.order]);
    return v_flex().id("zebra-sidebar").size_full().min_h(0).text_size(13).text_color(t.foreground)
      .child(v_flex().id("sidebar-list").flex_1().min_h(0).overflow_y_scrollbar()
        .on_mouse_up("left", (_e, cx) => { this.pressed = null; cx.notify(); })
        .when(pinned.length > 0, el => el.child(this.section(t, "pinned", "Pinned", "dim", pinned.flatMap(a => this.agentRow(t, a, ctx)))))
        .children(view.items));
  }
}
