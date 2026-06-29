#!/bin/bash
# generate_video.sh - 从脚本 Markdown 生成短视频
# 用法: generate_video.sh <脚本路径> [输出路径]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE="$(cd "$SCRIPT_DIR/.." && pwd)"
GEN_SCRIPT="$WORKSPACE/../skills/lh-video-gen/scripts/generate.py"

SCRIPT_PATH="${1:-}"
OUTPUT="${2:-$WORKSPACE/output/video_$(date +%Y%m%d_%H%M%S).mp4}"

if [ -z "$SCRIPT_PATH" ]; then
  echo "❌ 用法: generate_video.sh <脚本路径> [输出路径]"
  exit 1
fi

if [ ! -f "$SCRIPT_PATH" ]; then
  echo "❌ 脚本文件不存在: $SCRIPT_PATH"
  exit 1
fi

mkdir -p "$WORKSPACE/output"
mkdir -p "$WORKSPACE/tmp"

echo "🎬 开始生成视频..."
echo "   脚本: $SCRIPT_PATH"
echo "   输出: $OUTPUT"

python3 "$GEN_SCRIPT" \
  "$SCRIPT_PATH" \
  -o "$OUTPUT" \
  -v "zh-CN-YunxiNeural" \
  -r "+10%" \
  --keep-temp

echo "✅ 视频生成完成: $OUTPUT"
echo "📊 文件大小: $(du -h "$OUTPUT" | cut -f1)"
echo "📐 分辨率: 1080×1920 (9:16)"

# 同步到共享目录
SHARE_DIR="/mnt/hgfs/NovaShared/OutPut/drama/"
if [ -d "$SHARE_DIR" ]; then
  mkdir -p "$SHARE_DIR"
  cp "$OUTPUT" "$SHARE_DIR/"
  echo "📤 已同步到共享目录: $SHARE_DIR"
fi

echo "$OUTPUT"
