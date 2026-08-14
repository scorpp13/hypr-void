#!/usr/bin/bash
set -euo pipefail

GREEN=$'\033[0;32m'

DIR=$(gum file --directory "$HOME")
INPUT=$(find "$DIR" | gum choose --no-limit)

if [[ -z "${INPUT}" ]]; then
  notify-send "No images selected"
  exit 0
fi

# Infer extension from the first selected file
FIRST=${INPUT%%$'\n'*}
BASENAME=$(basename "$FIRST")
EXTENSION="${BASENAME##*.}"

OUTPUT="merge_$(date '+d%m%y_%H%M%S')"
FORMAT=$(gum input --prompt "Merging format: " --placeholder "columns X lines")

if gum confirm "Merge selected images?"; then
  cd "$DIR" || exit 1

  # Build a safe montage argument list from newline-separated INPUT,
  # preserving filenames with spaces.
  files=()
  while IFS= read -r line; do
    [[ -n "$line" ]] && files+=("$line")
  done <<< "$INPUT"

  gum spin --title "Merging..." -- \
    montage "${files[@]}" -tile "$FORMAT" -geometry +0+0 "${OUTPUT}.${EXTENSION}"

  rc=$?
  if [[ $rc -eq 130 ]]; then
    notify-send "Canceled by user"
    exit 130
  elif [[ $rc -ne 0 ]]; then
    notify-send "Merging interrupted"
    exit "$rc"
  fi
else
  notify-send "Canceled by user"
  exit 130
fi

notify-send "Merging finished"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
