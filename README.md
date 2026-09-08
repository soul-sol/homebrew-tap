# soul-sol Homebrew tap

```
brew tap soul-sol/tap
brew trust soul-sol/tap   # Homebrew refuses third-party taps until you trust them
brew install agent-watch
```

## agent-watch

Tells `DONE`, `FAILED` and `STALL` apart using the recorded exit code and result-body failure signals.
Read the result body before accepting `DONE`: an approval-only response can exit cleanly without doing
the work. Completion markers are supplementary diagnostics; their absence alone is never `STALL`.
`STALL` is reserved for unavailable or invalid evidence such as a PID record, log, or exit code.

```
agent-launch build ./logs -- codex exec "implement X"
agent-watch  build $(cat logs/build.pid) logs/build.log codex logs/build.exit
```

Exit codes: `0` when the run is `DONE` or still `RUNNING`, non-zero for `FAILED` and `STALL`, so it
works as a CI gate. Source and full documentation: https://github.com/soul-sol/agent-watch
