#!/bin/zsh
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
set -euo pipefail

# ===== 你要的輸出尺寸（改這裡） =====
WIDTH=1280
HEIGHT=720

# ===== 轉檔品質/速度（通常不用改） =====
CRF=20          # 18~23 常用；越小越清晰越大
PRESET=medium   # faster/medium/slow

# 取得輸入資料夾（Automator 會把你拖進來的資料夾當參數）
if [[ $# -lt 1 ]]; then
  echo "請把資料夾拖到這個 App 上執行。"
  exit 1
fi

for dir in "$@"; do
  [[ -d "$dir" ]] || continue

  outdir="${dir%/}/converted_mp4"
  mkdir -p "$outdir"

  # 找出所有 .avi（忽略大小寫）
  found_any=0
  while IFS= read -r -d '' f; do
    found_any=1
    base="$(basename "$f")"
    name="${base%.*}"
    out="$outdir/${name}.mp4"

    echo "轉檔中：$base -> $(basename "$out")"

    # 1) force_original_aspect_ratio=decrease：等比縮小到塞進指定尺寸
    # 2) pad：不足的邊補黑，最後得到「精準 WIDTHxHEIGHT」
    ffmpeg -nostdin -loglevel warning -hide_banner -y -i "$f" \
  -c:v libx264 -preset "$PRESET" -crf "$CRF" \
  -vf "scale=${WIDTH}:${HEIGHT}:force_original_aspect_ratio=decrease,pad=${WIDTH}:${HEIGHT}:(ow-iw)/2:(oh-ih)/2" \
  -pix_fmt yuv420p -c:a aac -b:a 192k -movflags +faststart \
  "$out" 2>&1

  done < <(find "$dir" -maxdepth 1 -type f \( -iname '*.avi' \) -print0)

  if [[ $found_any -eq 0 ]]; then
    echo "資料夾沒有找到 .avi：$dir"
  else
    echo "完成：$outdir"
  fi
done

