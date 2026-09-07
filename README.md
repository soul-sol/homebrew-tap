# soul-sol Homebrew tap

```
brew tap soul-sol/tap
brew install agent-watch
```

## agent-watch

Tells `DONE`, `FAILED` and `STALL` apart when a coding agent exits. A worker that stops to ask for
approval exits cleanly and leaves a log that reads like success; this checks the recorded exit code
*and* a completion marker, and treats a missing marker as a stall rather than a pass.

```
agent-launch build ./logs -- codex exec "implement X"
agent-watch  build $(cat logs/build.pid) logs/build.log codex logs/build.exit
```

Exit codes: `0` when the run is `DONE` or still `RUNNING`, non-zero for `FAILED` and `STALL`, so it
works as a CI gate. Source and full documentation: https://github.com/soul-sol/agent-watch
