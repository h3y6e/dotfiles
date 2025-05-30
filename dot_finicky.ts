import type { FinickyConfig } from "/Applications/Finicky.app/Contents/Resources/finicky.d.ts";

// see: https://github.com/johnste/finicky/wiki/Configuration-(v4)
export default {
  defaultBrowser: "Firefox Developer Edition",
  handlers: [
    {
      match: (url) =>
        [
          "google.com",
          "figma.com",
          "linear.app",
          "inspect.isar.dev",
          "inspect.isar-community.dev",
        ].some(
          (host) => url.host.endsWith(host)
        ),
      browser: "Arc",
    },
  ],
} satisfies FinickyConfig;
