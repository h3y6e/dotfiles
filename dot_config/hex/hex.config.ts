import { defineHexConfig } from "@hex/commands"

export default defineHexConfig({
  transformations: {
    "no-trailing-kuten": {
      name: "No trailing 。",
      description: "Drops the final 。",
      transform: (text) => text.trimEnd().replace(/。+$/u, ""),
    },
  },
})
