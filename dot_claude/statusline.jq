def c(n): "\u001b[\(n)m\(.)\u001b[0m";
def bar: floor as $p | ($p / 10 | round) as $n | "\("█" * $n)\("░" * (10 - $n)) \($p)%";
def limit(f): "\(.used_percentage | bar) \("↻\(.resets_at | strflocaltime(f))" | c(2))";
def tilde: sub("^" + env.HOME; "~");
( [ "ctx \(.context_window.used_percentage // empty | bar)",
    (.prompt_cache // empty |
      "cache hit \(.hit_ratio * 100 | floor)%",
      "miss \(.misses)",
      "exp \(.expires_at // empty | strflocaltime("%H:%M"))") ],
  [ "limit 5h \(.rate_limits.five_hour // empty | limit("%H:%M"))",
    "7d \(.rate_limits.seven_day // empty | limit("%m/%d(%a) %H:%M"))" ],
  [ "\(.workspace.project_dir | tilde) \("→ \(.workspace.current_dir | tilde)" | c(2))",
    (.pr // empty | "PR #\(.number) \(.review_state // "")" | c(35)),
    "\("+\(.cost.total_lines_added)" | c(32)) \("-\(.cost.total_lines_removed)" | c(31))" ]
) | join(" · " | c(2))
