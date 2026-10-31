import { View, div, svg } from "gpui-kit";
import { h_flex } from "gpui-base";
import { theme, run, window, props, shared, setShared } from "herdr";

export default class WorkspaceChrome extends View {
  button(id, label, action) {
    const t = theme();
    return div().id(id).size(22).flex_none().flex().items_center().justify_center().rounded(4).text_color(t.muted).hover(s => s.bg(t.hover))
      .on_mouse_down("left", (_e, cx) => cx.stop_propagation()).on_click(action).child(label);
  }
  render() {
    const t = theme();
    if (props()?.footer) {
      const priority = shared("zebra.sort") === "priority";
      return h_flex().size_full().bg(t.chrome).px(4).gap(2).items_center().border_t(1).border_color(t.border)
        .child(this.button("sidebar-hide", svg("mods/zebra-workspace-chrome/icon/sidebar.svg").size(14), () => run("layout.hide", { id: "sidebar" })))
        .child(this.button("sidebar-sort", svg(`mods/zebra-workspace-chrome/icon/${priority ? "clock" : "layers"}.svg`).size(14), () => setShared("zebra.sort", priority ? "grouped" : "priority")))
        .child(div().flex_1())
        .child(this.button("space-new", svg("mods/zebra-workspace-chrome/icon/folder-plus.svg").size(14), () => run("space.new")));
    }
    return h_flex().size_full().bg(t.chrome).pl(window()?.platform === "macos" ? 72 : 10).pr(6).gap(8).items_center().text_size(13)
      .border_b(1).border_color(t.border)
      .child(div().flex_1())
      .child(this.button("search", svg("mods/zebra-workspace-chrome/icon/search.svg").size(14), () => run("mod.open", { name: "picker" })))
;
  }
}
