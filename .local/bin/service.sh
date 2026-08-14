#!/usr/bin/bash
set -euo pipefail

sudo vsv
echo ""

if gum confirm "Show Help?"; then
  vsv --help
fi

echo ""
echo ""

if gum confirm "Stayin' Shell?"; then
  check_and_start() {
    bin=$1

    if ! pgrep -x "$bin" >/dev/null 2>&1; then
      "$bin"
    else
      "$SHELL"
    fi
  }

  check_and_start "/usr/bin/fish"
fi
