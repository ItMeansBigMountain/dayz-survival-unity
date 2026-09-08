# Live Unity Editor onboarding

The primary Unity Editor runs on the Windows workstation so the operator can watch Hermes-driven changes immediately. The VPS remains the automation/build host.

## Windows bootstrap

1. Install Unity Hub and sign in.
2. Install the exact project Editor version: Unity `6000.0.83f1`.
3. Clone this repository.
4. In PowerShell from the repository root, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\Setup-LiveUnityMcp.ps1
```

The script validates the pinned MCP package, opens the project, and waits until the Editor bridge listens on `127.0.0.1:8090`.

## Security boundary

- The bridge remains loopback-only by default.
- Package installation through MCP remains disabled.
- Do not expose port 8090 directly to the internet.
- Connect the VPS through an authenticated encrypted tunnel only.
- The bridge authentication token is generated under `Library/McpUnity/bridge-token`; `Library/` is Git-ignored and the token must never be committed or pasted into Discord.

## Verification

Successful onboarding requires all of the following:

1. Unity Editor visibly opens the project on Windows.
2. `Tools > MCP Unity > Server Window` reports the server running.
3. Windows reports `127.0.0.1:8090` listening.
4. Hermes discovers the MCP tools through the encrypted tunnel.
5. Hermes invokes `get_console_logs` and performs a reversible scene edit that appears in the open Editor.