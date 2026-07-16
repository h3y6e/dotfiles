# Publishing an Issue

Read this only when the user has approved the title, body, node granularity, and dependency edges, and has requested publishing.

## Pre-publish checks

- Identify the target tracker and repository, and check authentication status.
- Confirm only approved, `ready` nodes are being published, and leave `blocked` nodes in the draft.
- Check the repository's visibility, and its issue template, existing labels, issue types, and linking features.
- Right before publishing, redo the duplicate search by whether it points at the same problem or decision, not by wording.
- If a new duplicate candidate turns up, stop publishing, decide to adopt, merge, or exclude it, and return to the draft-and-approval step.
- When publishing security findings, credential locations, or personal information to a public tracker, show the content and get separate approval.
- When the approved draft conflicts with a required tracker field, present the proposed change and get re-approval.
- When the tracker lacks native linking and `Blocked by` is added to the body, present the full converted body and get re-approval.

## Publishing

1. Create nodes in topological order, blockers first, and record each ID and URL.
2. After every node has an ID, connect blocking and parent-child relationships using tracker-native linking.
3. Only for a tracker without native linking, fall back to the approved body's `Blocked by`.
4. Don't modify or close a parent or source issue without an explicit request.
5. Read back each issue and its links, and compare against the approved title, body, edges, labels, and type.

## Partial Failure

Report created issues, un-created nodes, and unconnected edges separately, then stop.
Don't unconditionally retry the same node, or auto-delete an already-created issue.
Before resuming, read back the tracker's current state and present only the remaining work.

On completion, return every issue's ID, title, and URL, plus the verification result of the links.
