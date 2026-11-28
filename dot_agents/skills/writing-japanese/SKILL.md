---
description: Norms for Japanese prose — paragraph logic, argument rigor, reader load, restrained rhetoric, and non-LLM phrasing. Use when writing or editing Japanese text that will be saved or published, even a single line or a draft another skill produces (docs, articles, explanations, PR/issue bodies, commit messages, description fields), or when reviewing Japanese prose. Not for chat replies to the user.
metadata:
    github-path: skills/writing-japanese
    github-ref: refs/tags/v2026.11.11
    github-repo: https://github.com/h3y6e/agent-skills
    github-tree-sha: 1508c35469348ea05866d702127b648081278378
    refs: https://gist.github.com/k16shikano/fd287c3133457c4fd8f5601d34aa817d, https://gist.github.com/k16shikano/eb2929f13ed19c97188393d297be8432, https://github.com/nanaism/yomiyasu, https://github.com/53able/no-ai-slop-ja, https://github.com/Forest-Project-Lab/jp-writing-skills, https://github.com/textlint-ja/textlint-rule-preset-ai-writing
    version: 2026.11.11
name: writing-japanese
---
# 日本語の文章規範

規則は禁止語の一覧ではない。直すのは読み違いや読みにくさを生む箇所だけで、「除外」に当たる箇所は残す。

## 意味を変えず、足さない

ほかの規則より優先する。直した後も、動作主、対象、時制と相、可能・義務・予定・実施済みの区別、確度、因果、条件、数値、固有名、引用を保つ。

- 予定を確定や完了に、推量を断定に変えない。確かめていないことを確かめたように書かない。「かもしれない」を削るのは根拠なく弱めているときだけ。
- 原文にない事実、理由、例、評価、動作主を足さない。
- 意味を保って直せない箇所は、直さずに残す。

## LLM 口調と翻訳調

| 型 | 例 | 直し |
|---|---|---|
| 予告・総括 | 重要なのは〜／まとめると | 主張をそのまま書く |
| 空虚な語 | 包括的／不可欠／深掘りする／正面から扱う | 何をどう見たか、何をしたかを書く |
| 誇張・権威づけ | 革命的／完全に解決／多くの人が見落とす | 確かめた事実、数値、出典に置き換えるか削る |
| 決め台詞 | 単なる A ではない。B だ。 | B を述べる |
| 直訳の比喩 | 問いが開かれている／選好を運ぶ | 未解決である／選好が反映される |
| 無生物主語 | データが語る／モデルは知っている | データから分かる／出力に〜がある |
| 話し言葉 | 効く／刺さる／筋がいい | 効果の中身を書く |

翻訳調は英語に戻して判定する。英語の慣用句や構文にそのまま戻り、日本語では字義どおりの像が浮かぶなら直す。
除外: 誤解を正す「A ではなく B」（原因はキャッシュではなく DNS）、出典のある評価、行動を決める重要度の表示、定着した借用語。

## 詰まった文

- 「検証を行う」→「検証する」、「変更することができる」→「変更できる」
- 「の」の連鎖: 「開発の速度の改善の方法」→「開発速度を上げる方法」
- 助詞を落とした漢語: 「書類不備発見時は」→「書類に不備を見つけたときは」

除外: 正式名称、定着した複合語（ログイン画面）、法令や規程の定義語、その文書でふつうに使う漢語（確認する、使用する）。

## 読点と文末

- 短い主題・主語・目的語の直後の読点は外す（「本 PR は、」→「本 PR は」）。除外: 外すと係り先が二通りに読める箇所、長い節のあと、条件・逆接・理由の切れ目、並列、文頭の接続語のあと。
- 同じ文末を三文以上続けない（「〜します。〜します。〜します。」）。並列の事実は一文にまとめる。除外: 手順書や仕様で、揃った文末が一貫性を担う箇所。

## 書式

- 箇条書きの太字ラベル（`- **改善点**: 〜`）は、述語のある文にする（`- エラー文に原因の項目名を出す`）。除外: 日時、担当、数値、設定項目のように値を示すラベル。
- 太字は誤読を防ぐ否定など論理の要所に限る。絵文字、見出し末のコロンは使わない。
- description 欄やそれに類する短い説明文では、文末に「。」を付けない。
- 識別子と定着した術語を除き、英語を混ぜない（「変更を apply する」→「変更を適用する」）。

## 冗長

- 同じ主張を言い換えて繰り返さない。締めの要約や言い直しは削る。削る前に、そこにしかない条件、数値、例外がないか確かめ、あれば本文へ移す。
- 接続や評価のためだけの文（「それ自体はよいことである」）や、読者との問答を演じる文を置かない。
- 冗長は字数で判定しない。動作主、条件、因果を読者の推論に委ねる圧縮はしない。

## 長い文章

段落や節を持つ文章（記事、書籍の章、設計文書、長い解説）では、[長文の規範](references/long-form.md) も読んで段落構成、論証、読み手の負荷、見出しを点検する。
最後まで読ませたい読み物を書くとき、または「密度はあるが平坦」な文章を直すときは、[認知リズムの規範](references/pacing-and-tension.md) も読む。
