#!/bin/bash
# pipeline.sh - 短剧自动创作流水线（被 AI Agent 调用）
# 此脚本由 drama agent 的 cron 任务触发
# 
# 流程:
#   1. 接收热点关键词作为输入
#   2. 生成脚本 Markdown
#   3. 调用 lh-video-gen 生成视频
#   4. 上传到蚁小二
#
# 注意: 热点采集和脚本创作由 Agent 的 AI 能力完成
#       此脚本只处理生成和发布等"体力活"

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE="$(cd "$SCRIPT_DIR/.." && pwd)"
OUTPUT_DIR="$WORKSPACE/output"
TMP_DIR="$WORKSPACE/tmp"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$OUTPUT_DIR" "$TMP_DIR"

echo "═══════════════════════════════════════════"
echo "  🎬 短剧自动流水线 - $TIMESTAMP"
echo "═══════════════════════════════════════════"

# 输出流水线状态，供 Agent 读取判断
exec > >(tee -a "$TMP_DIR/pipeline_${TIMESTAMP}.log") 2>&1

echo "✅ 流水线就绪"
echo ""
echo "📌 使用说明（给 Agent）："
echo "   1. web_search → 获取今天最火的短剧热点"
echo "   2. 创作脚本 → 写入脚本 Markdown 文件"
echo "   3. 生成视频 → bash scripts/generate_video.sh <脚本路径>"
echo "   4. 发布     → node <yixiaoer_api> 上传+发布"
echo ""
echo "═══════════════════════════════════════════"
