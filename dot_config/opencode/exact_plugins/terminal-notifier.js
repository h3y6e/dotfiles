const SPINNER_FRAMES = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];
const INPUT_FRAMES = ["◆", "◇"];

export const TerminalNotifier = async ({ client }) => {
  const titles = new Map();
  let activeSessionID;
  let status = "idle";
  let asking = false;
  let frame = 0;
  let interval;

  const displayTitle = (title) => {
    const clean = String(title ?? "");
    return clean.length > 40 ? `${clean.slice(0, 37)}...` : clean;
  };
  const titlePrefix = () => {
    if (asking) return INPUT_FRAMES[frame % INPUT_FRAMES.length];
    if (status === "idle") return "▣";
    return SPINNER_FRAMES[frame % SPINNER_FRAMES.length];
  };
  const writeTitle = () => {
    process.stdout.write(
      `\x1b]0;${titlePrefix()} ${displayTitle(activeSessionID ? titles.get(activeSessionID) : undefined)}\x1b\\`,
    );
  };
  const stopAnimation = () => {
    if (!interval) return;
    clearInterval(interval);
    interval = undefined;
    frame = 0;
  };
  const startAnimation = () => {
    if (interval) return;
    interval = setInterval(() => {
      frame += 1;
      writeTitle();
    }, 200);
  };
  const fetchTitle = async (id) => {
    if (!id || titles.has(id)) return;
    try {
      const session = await client.session.get({ path: { id } });
      const title = session.data?.title ?? session.title;
      if (title) titles.set(id, title);
    } catch {
      // Title refresh is best effort
    }
  };

  return {
    dispose: async () => stopAnimation(),
    event: async ({ event }) => {
      const properties = event.properties ?? event.payload ?? event;
      activeSessionID = properties.sessionID ?? activeSessionID;

      if (activeSessionID && properties.info?.title) {
        titles.set(activeSessionID, properties.info.title);
      }

      switch (event.type) {
        case "session.status":
          status = properties.status?.type ?? properties.status ?? status;
          break;
        case "session.idle":
          process.stdout.write("\x07");
          status = "idle";
          break;
        case "session.updated":
          break;
        case "permission.asked":
        case "question.asked":
          process.stdout.write("\x07");
          asking = true;
          frame = 0;
          break;
        case "permission.replied":
        case "question.replied":
        case "question.rejected":
          asking = false;
          frame = 0;
          break;
        default:
          return;
      }

      await fetchTitle(activeSessionID);

      if (asking || status !== "idle") startAnimation();
      else stopAnimation();

      writeTitle();
    },
  };
};
