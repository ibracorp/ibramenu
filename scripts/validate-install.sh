#!/bin/bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
temp_root="$(mktemp -d)"
cleanup() {
  rm -rf "$temp_root"
}
trap cleanup EXIT

export IBRAMENU_PREFIX="${temp_root}/ibracorp"
export IBRAMENU_INSTALL_ROOT="${IBRAMENU_PREFIX}/ibramenu"
export IBRAMENU_CLONE_SOURCE="${repo_root}"
export IBRAMENU_CLONE_BRANCH="$(git -C "$repo_root" rev-parse --abbrev-ref HEAD)"
export IBRAMENU_SKIP_PACKAGES=1
export IBRAMENU_SKIP_ALIASES=1
export IBRAMENU_SKIP_MOTD=1

printf "Validating install into %s\n" "$IBRAMENU_INSTALL_ROOT"
"${repo_root}/ibrainstall.sh"

test -d "$IBRAMENU_INSTALL_ROOT"
test -x "$IBRAMENU_INSTALL_ROOT/ibramenu.sh"
test -x "$IBRAMENU_INSTALL_ROOT/ibraupdate.sh"
test -x "$IBRAMENU_INSTALL_ROOT/ibrauninstall.sh"
test -d "$IBRAMENU_INSTALL_ROOT/MenuOptions"

printf "Install validation complete.\n"
