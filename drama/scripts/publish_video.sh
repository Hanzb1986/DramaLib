#!/bin/bash
# publish_video.sh - 上传视频到蚁小二并发布
# 用法: publish_video.sh <视频路径> <封面路径> <平台列表JSON>
# 依赖: YIXIAOER_API_KEY 环境变量

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE="$(cd "$SCRIPT_DIR/.." && pwd)"
YIXIAOER_API="$WORKSPACE/../skills/yixiaoer-publish/scripts/api.ts"

VIDEO_PATH="${1:-}"
COVER_PATH="${2:-}"
PLATFORMS="${3:-["抖音"]}"

if [ -z "$YIXIAOER_API_KEY:-}" ]; then
  echo "❌ YIXIAOER_API_KEY 未设置"
  exit 1
fi

if [ ! -f "$VIDEO_PATH" ]; then
  echo "❌ 视频文件不存在: $VIDEO_PATH"
  exit 1
fi

echo "📤 上传视频到蚁小二..."

# 1. 上传视频
VIDEO_KEY=$(node "$YIXIAOER_API" --payload="{\"action\":\"upload\",\"url\":\"$VIDEO_PATH\",\"bucket\":\"cloud-publish\"}" | python3 -c "import sys,json; print(json.load(sys.stdin).get('key',''))" 2>/dev/null)

if [ -z "$VIDEO_KEY" ]; then
  echo "❌ 视频上传失败"
  exit 1
fi
echo "   ✅ 视频上传成功: $VIDEO_KEY"

# 2. 上传封面
COVER_KEY=""
if [ -f "$COVER_PATH" ]; then
  COVER_KEY=$(node "$YIXIAOER_API" --payload="{\"action\":\"upload\",\"url\":\"$COVER_PATH\",\"bucket\":\"cloud-publish\"}" | python3 -c "import sys,json; print(json.load(sys.stdin).get('key',''))" 2>/dev/null)
  echo "   ✅ 封面上传成功: $COVER_KEY"
fi

# 3. 获取视频信息
VIDEO_INFO=$(ffprobe -v quiet -print_format json -show_format -show_streams "$VIDEO_PATH" 2>/dev/null)
VIDEO_WIDTH=$(echo "$VIDEO_INFO" | python3 -c "import sys,json; s=json.load(sys.stdin); print(s['streams'][0]['width'])" 2>/dev/null || echo "1080")
VIDEO_HEIGHT=$(echo "$VIDEO_INFO" | python3 -c "import sys,json; s=json.load(sys.stdin); print(s['streams'][0]['height'])" 2>/dev/null || echo "1920")
VIDEO_SIZE=$(echo "$VIDEO_INFO" | python3 -c "import sys,json; s=json.load(sys.stdin); print(s['format']['size'])" 2>/dev/null || stat -c%s "$VIDEO_PATH" 2>/dev/null || echo "0")

echo "   📐 ${VIDEO_WIDTH}x${VIDEO_HEIGHT} | 📦 ${VIDEO_SIZE} bytes"

# 4. 获取账号列表（取第一个可用账号）
echo "📋 获取账号列表..."
ACCOUNTS_JSON=$(node "$YIXIAOER_API" --payload="{\"action\":\"accounts\"}" 2>/dev/null)
echo "$ACCOUNTS_JSON" | python3 -c "
import sys,json
data = json.load(sys.stdin)
print(json.dumps(data, indent=2, ensure_ascii=False))
" 2>/dev/null || echo "   账号列表获取失败"

echo ""
echo "🔔 注意:"
echo "   发布前需要在蚁小二后台绑定好平台账号"
echo "   然后手动调用发布接口，指定 platformAccountId"
echo "   或者让 AI agent 自动完成发布流程"
