#!/bin/bash
set -euo pipefail

######################################################################
# Title   : IBRAINSTALL Installer and Updater for IBRAMENU
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Install configuration (overridable for testing)
prefix_dir="${IBRAMENU_PREFIX:-/opt/ibracorp}"
ifolder="${IBRAMENU_INSTALL_ROOT:-${prefix_dir}/ibramenu}"
clone_source="${IBRAMENU_CLONE_SOURCE:-https://github.com/ibracorp/ibramenu.git}"
clone_branch="${IBRAMENU_CLONE_BRANCH:-main}"
skip_packages="${IBRAMENU_SKIP_PACKAGES:-0}"
skip_aliases="${IBRAMENU_SKIP_ALIASES:-0}"
skip_motd="${IBRAMENU_SKIP_MOTD:-0}"

# Check for existing ibramenu folder and clean up if needed
if [ -d "$ifolder" ]; then
  rm -rf "$ifolder"
fi
mkdir -p "$ifolder"

# Clone ibramenu
if [ "$skip_packages" -ne 1 ]; then
  apt update
  apt install sudo curl git ruby ruby-dev build-essential -y
  gem install mdless --no-document
fi
git clone -b "$clone_branch" --single-branch "$clone_source" "$ifolder"
find "$ifolder" -type f -iname "*.sh" -exec chmod +x {} \;

# Add ibramenu as systemwide alias
if [ "$skip_aliases" -ne 1 ]; then
  if ! grep -q ibramenu /etc/bash.bashrc
  then
    insert_alias="alias ibramenu='sudo ${ifolder}/ibramenu.sh'"
    echo $insert_alias | sudo tee -a /etc/bash.bashrc > /dev/null
    set +u
    source /etc/bash.bashrc
    set -u
  fi
  # Add ibraupdate as systemwide alias
  if ! grep -q ibraupdate /etc/bash.bashrc
  then
    insert_alias="alias ibraupdate='sudo ${ifolder}/ibraupdate.sh'"
    echo $insert_alias | sudo tee -a /etc/bash.bashrc > /dev/null
    set +u
    source /etc/bash.bashrc
    set -u
  fi
  # Add ibrauninstall as systemwide alias
  if ! grep -q ibrauninstall /etc/bash.bashrc
  then
    insert_alias="alias ibrauninstall='sudo ${ifolder}/ibrauninstall.sh'"
    echo $insert_alias | sudo tee -a /etc/bash.bashrc > /dev/null
    set +u
    source /etc/bash.bashrc
    set -u
  fi
fi

# Include ibrafunc for all the awesome functions
if [ "$skip_motd" -ne 1 ]; then
  source "${ifolder}/ibrafunc.sh"
  ibramotd
  ibralogo
fi
if [[ -n ${1-} ]]
then
  if [ "$1" = all ]
  then
    cd "/opt/ibracorp/ibramenu/MenuOptions/Submenu Basic Install Steps/All Steps in One"
    "./All Steps in One.sh"
    reboot
  else
    msgbox "Type 'ibramenu' to launch IBRAMENU"
    msgbox "Type 'ibraupdate' to update"
    msgbox "Type 'ibrauninstall' to uninstall"
    msgbox "Please reboot after the first installation"
  fi
fi
