import { execFile } from "node:child_process";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);
const ATTENTION_EVENTS = new Set(["permission.asked", "question.asked"]);
const CLEAR_EVENTS = new Set(["permission.replied", "question.replied", "question.rejected"]);
const WINDOW_OPTION = "@opencode_window_waiting";

async function runCommand(command, args) {
  try {
    const { stdout } = await execFileAsync(command, args, { timeout: 1500 });
    return stdout.trim();
  } catch {
    return "";
  }
}

async function runTmux(args) {
  return runCommand("tmux", args);
}

async function refreshTmux() {
  await runTmux(["refresh-client", "-S"]);
}

async function getTmuxContext() {
  const pane = process.env.TMUX_PANE;
  if (!pane) {
    return null;
  }

  const output = await runTmux([
    "display-message",
    "-p",
    "-t",
    pane,
    "#{window_id}",
  ]);

  if (!output) {
    return null;
  }

  return { pane, window: output };
}

async function showAttentionAlert() {
  if (process.platform !== "darwin") {
    return;
  }

  const beep = process.env.OPENCODE_TMUX_ALERT_BEEP !== "false";
  const notify = process.env.OPENCODE_TMUX_ALERT_NOTIFY === "true";

  if (beep) {
    await runCommand("osascript", ["-e", "beep 1"]);
  }

  if (notify) {
    await runCommand("osascript", [
      "-e",
      'display notification "OpenCode is waiting for you" with title "OpenCode"',
    ]);
  }
}

export const TmuxAttentionPlugin = async () => {
  let hasSeenBusy = false;
  let isWaiting = false;
  let isAwaitingUser = false;

  async function setAttention(nextWaiting) {
    if (nextWaiting === isWaiting) {
      return;
    }

    isWaiting = nextWaiting;

    const tmux = await getTmuxContext();
    if (!tmux) {
      return;
    }

    await runTmux([
      "set-option",
      "-q",
      "-w",
      "-t",
      tmux.window,
      WINDOW_OPTION,
      nextWaiting ? "1" : "0",
    ]);
    await refreshTmux();

    if (nextWaiting) {
      await showAttentionAlert();
    }
  }

  await setAttention(false);

  return {
    "permission.ask": async () => {
      isAwaitingUser = true;
      await setAttention(true);
    },
    event: async ({ event }) => {
      if (ATTENTION_EVENTS.has(event.type)) {
        isAwaitingUser = true;
        await setAttention(true);
        return;
      }

      if (CLEAR_EVENTS.has(event.type)) {
        isAwaitingUser = false;
        await setAttention(false);
        return;
      }

      if (event.type === "session.status") {
        if (event.properties.status.type === "busy") {
          hasSeenBusy = true;
        }

        if (event.properties.status.type !== "idle" && !isAwaitingUser) {
          await setAttention(false);
        }

        return;
      }

      if (event.type === "session.idle" && hasSeenBusy && !isAwaitingUser) {
        await setAttention(true);
      }
    },
  };
};

export default TmuxAttentionPlugin;
