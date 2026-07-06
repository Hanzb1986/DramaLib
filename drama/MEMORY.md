# 🧠 Drama 记忆

## 📢 全局共享文件夹升级通知（2026-06-29 Nova 转达）

### 新目录结构
顶层挂载 `/mnt/hgfs/ElliShared/` 已拆分三个独立子目录：

| 智能体 | 共享 Input | 共享 OutPut | 本地 Workspace |
|:------|:----------|:-----------|:--------------|
| Nova 🐚 | `ElliShared/Nova/Input` | `ElliShared/Nova/OutPut` | workspace/input + workspace/output |
| Drama 🎬 | **`ElliShared/Drama/Input`** | **`ElliShared/Drama/OutPut`** | **workspace-drama/input + workspace-drama/output** |
| Linna 🛍️ | `ElliShared/Linna/Input` | `ElliShared/Linna/OutPut` | workspace-linna/input + workspace-linna/output |

### 给你的规则变化
1. **投递入口：** 你用的共享 Input 是 `ElliShared/Drama/Input/`，不是老的 `ElliShared/Input/`
2. **成品出口：** 同步到 `ElliShared/Drama/OutPut/`
3. **本地不变：** 你本地 `workspace-drama/input/` 和 `workspace-drama/output/` 照旧
4. **流程不变：** 检测 Input → 拷贝到本地 → 删除共享源文件 → 本地处理 → 成品同步到共享 OutPut
5. **隔离：** 你不能读写 Nova/Linna 的目录，反之亦然

### 输出文件三步规则（你也要执行）
① **视频成品**生成到自身 `workspace-drama/output/`（只放最终视频/脚本，不放任何 .md 工作文件）
② 同步拷贝到共享 `ElliShared/Drama/OutPut/`
③ 微信渠道时额外发 MEDIA（仅 channel=openclaw-weixin 时触发）

> ⚠️ `output/` 是Hans的地盘，只放最终交付物。我的工作笔记、日志、缓存全部走 `drama/memory/`。

> 完整规则见 Nova 的 01_BUSINESS_CONFIG.md §1.2，三智能体复用同一套

### 📬 智能体通信机制（启动必读）

三智能体（Nova/Drama/Linna）间通过 `ElliShared/.comm/` 文件总线异步通信。

**每次启动必须：**
1. 查看 `ElliShared/.comm/to_Drama/` 目录是否有新消息
2. 有 `_URGENT` 前缀的优先处理
3. 读完移入 `ElliShared/.comm/archive/`
4. 需要回复就写到对方 `to_xxx/` 目录

> 详细协议见 `ElliShared/.comm/README.md` 或自己 01_BUSINESS_CONFIG.md §六
