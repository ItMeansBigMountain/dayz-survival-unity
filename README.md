# DayZ-Style Survival Unity 6 Project

Canonical Unity 6 URP survival project scaffold with `com.unity.ai.assistant` (Unity MCP) integration.

## Project Info
- **Unity Version**: 6000.0.83f1 (LTS)
- **Render Pipeline**: Universal Render Pipeline (URP) 17.0.0
- **MCP Package**: `com.unity.ai.assistant` 2.0.0-pre.1

## Structure
```
dayz-survival-unity/
├── Assets/              # Scenes, scripts, prefabs, materials
├── Packages/            # manifest.json (locked versions)
├── ProjectSettings/     # URP, graphics, project version
├── .gitignore           # Unity-standard ignores
└── README.md            # This file
```

## Prerequisites
- Unity 6.0.83f1 LTS installed (with WebGL module for browser builds)
- Unity Hub or CLI for project management
- Git for version control

## Quick Start

### 1. Open in Unity Editor
```bash
# Via Unity Hub
# File → Open → Select /opt/data/HeRmEz/projects/dayz-survival-unity

# Or via CLI (if on PATH)
unity -projectPath /opt/data/HeRmEz/projects/dayz-survival-unity
```

### 2. Verify Packages Resolve
- Open Package Manager (Window → Package Manager)
- Ensure all packages in `Packages/manifest.json` show as installed
- `com.unity.ai.assistant` should appear at version 2.0.0-pre.1

### 3. Enable Unity MCP (AI Assistant)
1. Open **Project Settings → AI → Unity MCP**
2. Sign in with your Unity account (first-time only)
3. Accept the AI Assistant terms
4. The relay binary installs to `~/.unity/relay/relay_linux`
5. Enable "Allow external clients" for MCP connections

### 4. Run MCP Relay for Hermes
```bash
# From project root or anywhere
~/.unity/relay/relay_linux --mcp

# Or via Unity CLI if configured
unity-mcp --projectPath /opt/data/HeRmEz/projects/dayz-survival-unity
```

The relay exposes Unity Editor tools via MCP (Model Context Protocol) on stdio.
Hermes can then call tools like `Unity_ReadConsole`, `Unity_GetGameObjects`, etc.

### 5. Build for WebGL
```bash
# Headless build via CLI
/opt/data/profiles/operations-engineer/home/Unity/Hub/Editor/6000.0.83f1/Editor/Unity \
  -batchmode \
  -projectPath /opt/data/HeRmEz/projects/dayz-survival-unity \
  -buildTarget WebGL \
  -executeMethod BuildScript.PerformWebGLBuild \
  -quit
```
> Requires a `BuildScript.cs` in `Assets/Editor/` with `PerformWebGLBuild` method.

### 6. Git Workflow
```bash
cd /opt/data/HeRmEz/projects/dayz-survival-unity
git init
git add .
git commit -m "Initial commit: Unity 6 URP scaffold with AI Assistant"
git branch -M main
git remote add origin https://github.com/<owner>/dayz-survival-unity.git
git push -u origin main
```

## Branch Protection (Recommended)
- Protect `main` branch
- Require PR reviews before merge
- Require status checks (Unity build, tests)

## MCP Smoke Test
With relay running (`relay_linux --mcp`), from Hermes:
```
Unity_ReadConsole {}
```
Should return recent Editor console output.

## License & Activation
Unity Editor requires valid license. First launch prompts for:
1. Unity ID sign-in
2. License selection (Personal/Pro/Enterprise)
3. AI Assistant terms acceptance (for MCP)

## Rollback / Cleanup
```bash
# Remove project
rm -rf /opt/data/HeRmEz/projects/dayz-survival-unity

# Remove Unity Editor (if installed via CLI)
unity-cli uninstall 6000.0.83f1

# Remove MCP relay
rm -rf ~/.unity/relay
```

## Next Steps
- Add minimal survival scene (terrain, player controller, inventory)
- Implement DayZ-style systems: health, hunger, infection, base building
- Configure Netcode for GameObjects for multiplayer
- Add addressables for content streaming

## Related
- Parent ops task: t_52b53d5d (Unity 6 + MCP install)
- Reviewer gate: verifies repo, build, MCP reachable