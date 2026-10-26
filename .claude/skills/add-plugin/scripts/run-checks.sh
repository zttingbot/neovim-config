#!/usr/bin/env bash
# Run every check for a newly added plugin: StyLua, then Neovim loading the
# plugin through catch-load-errors.lua, which fails on any error.
#
# Usage: run-checks.sh <lazy-name> [lua-module]

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: run-checks.sh <lazy-name> [lua-module]" >&2
  exit 2
fi

here=$(cd "$(dirname "$0")" && pwd)
cd "$(git -C "$here" rev-parse --show-toplevel)"

stylua=~/.local/share/nvim/mason/bin/stylua
[ -x "$stylua" ] || stylua=stylua
"$stylua" --check .

PLUGIN=$1 MODULE=${2-} nvim --headless --cmd "luafile $here/catch-load-errors.lua" "+lua check_plugin()" +qa
printf '\nOK: %s loads without errors\n' "$1"
