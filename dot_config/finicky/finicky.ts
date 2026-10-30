import type { FinickyConfig } from "/Applications/Finicky.app/Contents/Resources/finicky";

// see: https://github.com/johnste/finicky/wiki/Configuration-(v4)
export default {
  defaultBrowser: "Firefox Developer Edition",
  options: {
    hideIcon: true,
  },
  handlers: [
    {
      match: ["google.com/*", "*.google.com/*", "forms.gle/*"],
      browser: "Google Chrome",
    },
  ],
} satisfies FinickyConfig;
