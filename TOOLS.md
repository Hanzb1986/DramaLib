# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

## 共享目录（NovaShared）

> 所有 Agent 统一使用 `~/NovaShared/` 进行跨 Agent 文件交换。
> 旧 VMWare 共享 `/mnt/hgfs/ElliShared/` 已废弃。

- `~/NovaShared/Drama/` — 别人投递给我的文件
- `~/NovaShared/OutPut/` — 最终输出目录（统一）

## Related

- [Agent workspace](/concepts/agent-workspace)
