#!/bin/bash
set -euo pipefail

######################################################################
# Title   : IBRAUNINSTALL - Uninstaller for IBRAMENU
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

menu_dir="/opt/ibracorp/ibramenu"
bashrc_file="/etc/bash.bashrc"
profile_alias_file="/etc/profile.d/ibramenu.sh"

if [ -d "$menu_dir" ]; then
  rm -rf "$menu_dir"
fi

if [ -f "$bashrc_file" ]; then
  sed -i "/alias ibramenu=/d" "$bashrc_file"
  sed -i "/alias ibraupdate=/d" "$bashrc_file"
  sed -i "/alias ibrauninstall=/d" "$bashrc_file"
fi
if [ -f "$profile_alias_file" ]; then
  rm -f "$profile_alias_file"
fi

echo "IBRAMENU has been removed."
echo "Restart your login shell or run 'source /etc/profile' to refresh aliases."
