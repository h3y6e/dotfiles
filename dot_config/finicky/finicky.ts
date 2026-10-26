import type { FinickyConfig } from "/Applications/Finicky.app/Contents/Resources/finicky";

// see: https://github.com/johnste/finicky/wiki/Configuration-(v4)
export default {
  defaultBrowser: "Firefox Developer Edition",
  options: {
    hideIcon: true,
  },
  handlers: [
    {
      match: (url) => ["google.com"].some((host) => url.host.endsWith(host)),
      browser: "Google Chrome",
    },
  ],
} satisfies FinickyConfig;
