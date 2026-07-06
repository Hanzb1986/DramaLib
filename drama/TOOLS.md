# TOOLS.md - Drama 工作环境配置

## 📂 目录结构

- `input/` — 🫵 **Hans专用** — 你投递的素材/参考文件
- `output/` — 🫵 **Hans专用** — 你用的空间，我放视频成品过去
- `drama/` — 🎬 **Drama专用** — 我的工作区，你不会碰
  - `drama/memory/` — 记忆存储、工作日志、中间文件
  - `drama/scripts/` — 辅助脚本
  - `drama/templates/` — 模板

> ⚠️ 边界规则：`input/` 和 `output/` 是Hans的地盘，我不往里面写任何.md工作文件。
> 我的所有操作文件（日志、笔记、缓存）只放 `drama/` 下。

## 共享目录

- 收文件：`/mnt/hgfs/ElliShared/Drama/Input/`
- 发文件：`/mnt/hgfs/ElliShared/Drama/OutPut/`
- 通信：`/mnt/hgfs/ElliShared/.comm/`

## Git

- 仓库：`git@drama.github.com:Hanzb1986/DramaLib.git`
- Deploy key：`~/.ssh/drama-deploy`

## 技能

已配置 skill：
- `lh-video-gen` — 视频生成
- `yixiaoer` — 多平台发布
- `edge-tts` — 文本转语音
- `lh-edge-tts` — 语音合成
- `web-search` — 热点搜索

## 发布平台

通过蚁小二发布，配置见 openclaw.json。
