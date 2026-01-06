# Document Compression and Optimization

Reduce redundancy and improve clarity in documentation.

## Task

Compress and optimize the specified markdown file while preserving meaning and structure.

## Process

1. **Read and Analyze Target Document**
   - Understand overall structure and content
   - Identify relationships between sections

2. **Apply Compression Techniques**

   **A. Reduce Duplicate Information**
   - Identify content repeated across sections
   - Convert duplicates to cross-references (e.g., "See section X for details")
   - Unify different expressions of the same concept

   **B. Simplify Verbose Explanations**
   - Convert long paragraphs to bullet points
   - Summarize excessive details while retaining key information
   - Increase information density without losing meaning
   - Prefer concise, clear expressions over lengthy explanations

   **C. Detect Contradictions**
   - Identify inconsistencies between sections
   - Report conflicting statements or information
   - Flag content discrepancies (do NOT auto-fix)

   **D. Remove Historical Information**
   - Delete change logs and update timestamps
   - Remove phrases like "added X" or "changed to Y"
   - History can be tracked via git; documentation should not contain historical records

3. **Generate Compression Report**
   Include:
   - Applied compression techniques with specific examples
   - Line count before and after, with reduction percentage
   - Detected contradictions (if any)
   - Recommended next actions (if applicable)

## Guidelines

- **Preserve Meaning** - Do not sacrifice information quality for brevity
- **Maintain Structure** - Keep the original document organization
- **Be Explicit** - Show what was changed and why
- **Do NOT Auto-fix Contradictions** - Report them for manual review

## Output Format

First display the compression report, then apply edits to the file.

---

**Please provide the path to the markdown file you want to compress.**
