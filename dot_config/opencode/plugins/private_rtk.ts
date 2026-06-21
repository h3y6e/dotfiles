import type { Plugin } from "@opencode-ai/plugin";

export const RtkOpenCodePlugin: Plugin = async ({ $ }) => {
  try {
    await $`mise which rtk`.quiet();
  } catch {
    return {};
  }

  return {
    "tool.execute.before": async (input, output) => {
      const tool = String(input?.tool ?? "").toLowerCase();
      if (tool !== "bash" && tool !== "shell") return;
      const args = output?.args;
      if (!args || typeof args !== "object") return;

      const command = (args as Record<string, unknown>).command;
      if (typeof command !== "string" || !command) return;

      try {
        const result = await $`mise x -- rtk rewrite ${command}`
          .quiet()
          .nothrow();
        const rewritten = String(result.stdout).trim();
        if (rewritten && rewritten !== command) {
          (args as Record<string, unknown>).command = rewritten;
        }
      } catch {
        // rtk rewrite failed — pass through unchanged
      }
    },
  };
};
