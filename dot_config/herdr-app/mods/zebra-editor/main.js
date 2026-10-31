import { View, div } from "gpui-kit";
import { v_flex, h_flex, Editor, EditorState } from "gpui-base";
import { props, theme, settings, readTextFile, writeTextFile, watchFolder, nextCommand } from "herdr";

const LANG = { ts: "js", tsx: "js", mts: "js", cts: "js", jsx: "js", mjs: "js", toml: "yaml", jsonc: "json", svelte: "html", vue: "html" };

export default class ZebraEditor extends View {
  init(_props, cx) {
    this.file = props()?.file;
    this.saved = null; this.dirty = false; this.error = null;
    if (!this.file) return;
    cx.spawn(async cx => {
      const text = await readTextFile(this.file);
      if (text === null) this.error = "This file no longer exists";
      else {
        const t = theme(), name = this.file.split("/").pop(), ext = name.includes(".") ? name.split(".").pop() : "txt";
        this.saved = text;
        this.code = EditorState.new({ language: LANG[ext] ?? ext, value: text, font_family: settings().font_family, font_size: settings().font_size,
          syntax: { keyword: t.ansi5, string: t.ansi2, comment: t.dim, function: t.ansi4, type: t.ansi3, number: t.ansi1, constant: t.ansi6 } });
        this.code.on("change", (_e, cx) => { this.dirty = this.code.value() !== this.saved; cx.notify(); });
      }
      cx.notify();
    });
    cx.spawn(async cx => { for (;;) { if (await nextCommand() === "save") this.save(cx); } });
    cx.spawn(async cx => {
      const dir = this.file.slice(0, this.file.lastIndexOf("/"));
      for (;;) {
        const changed = await watchFolder(dir);
        if (!changed.includes(this.file) || !this.code || this.dirty) continue;
        const text = await readTextFile(this.file);
        if (text !== null && text !== this.saved) { this.saved = text; this.code.set_value(text); cx.notify(); }
      }
    });
  }

  save(cx) {
    if (!this.dirty) return;
    const text = this.code.value();
    cx.spawn(async cx => {
      try { await writeTextFile(this.file, text, this.saved); this.saved = text; this.dirty = this.code.value() !== text; this.error = null; }
      catch (e) { this.error = `Not saved: ${e}`; }
      cx.notify();
    });
  }

  render() {
    const t = theme();
    return v_flex().id("zebra-editor").size_full().min_h(0).bg(t.background).text_color(t.foreground).text_size(13)
      .child(h_flex().h(28).flex_none().px(12).gap(8).items_center().border_b(1).border_color(t.border)
        .child(div().flex_1().min_w(0).truncate().text_color(t.muted).child(this.file ?? ""))
        .when(this.dirty, el => el.child(div().size(7).flex_none().rounded_full().bg(t.foreground)))
        .when(Boolean(this.error), el => el.child(div().flex_none().text_color(t.ansi1).child(this.error))))
      .child(this.code ? Editor.new(this.code).flex_1().min_h(0) : div().flex_1());
  }
}
