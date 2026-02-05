#!/bin/bash
set -euo pipefail

######################################################################
# Title   : Beachhead - Initial Installer for IBRAMENU
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# IBRACORP logo
ibralogo () {
  tput clear
  tput bold
  tput setaf 1
  tee <<-EOF
  ___ ____  ____      _    ____ ___  ____  ____  ™
 |_ _| __ )|  _ \    / \  / ___/ _ \|  _ \|  _ \
  | ||  _ \| |_) |  / _ \| |  | | | | |_) | |_) |
  | || |_) |  _ <  / ___ \ |__| |_| |  _ <|  __/
 |___|____/|_| \_\/_/   \_\____\___/|_| \_\_|

IBRAINSTALL - Installer for IBRAMENU
Become a Member and sponsor us: https://ibracorp.io/memberships
EOF
  tput sgr0
}

disclaimer () {
  ibralogo
  tee <<-EOF

Thank you for installing IBRAMENU!

Please take a moment and read our IBRACORP Disclaimer:
https://docs.ibracorp.io/ibracorp/

EOF
  if [ "${IBRAMENU_NONINTERACTIVE:-0}" -ne 1 ]; then
    read -p "Press Enter to continue"
  fi
}

# Checklist
checklist () {
  ibralogo
  tee <<-EOF

Your System:

CPU Threads: $(lscpu | grep "CPU(s):" | tail +1 | head -1 | awk  '{print $2}')
IP: $(hostname -I | awk '{print $1}')
RAM: $(free -m | grep Mem | awk 'NR=1 {print $2}') MB

EOF

  # Check linux distribution
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    dist=$NAME
    release=$VERSION_ID
  elif type lsb_release >/dev/null 2>&1; then
    dist=$(lsb_release -si)
    release=$(lsb_release -sr)
  elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    dist=$DISTRIB_ID
    release=$DISTRIB_RELEASE
  elif [ -f /etc/debian_version ]; then
    dist=Debian
    release=$(cat /etc/debian_version)
  else
    dist=$(uname -s)
    release=$(uname -r)
  fi

  distribution="$dist $release"
  case $distribution in
    "Ubuntu 18.04" | "Ubuntu 20.04" | "Ubuntu 22.04" | "Ubuntu 22.10")
      echo "$distribution has been tested and works"
      echo
      sleep 3
      ;;
    "Debian GNU/Linux 10")
      echo "$distribution is considered experimental but will mostly work"
      echo "You will be asked if you want to switch the debian repositories from 'stable' to 'oldstable'. More info can be found here: https://wiki.debian.org/DebianOldStable"
      if [ "${IBRAMENU_NONINTERACTIVE:-0}" -ne 1 ]; then
        read -p "Press Enter to continue"
      fi
      ;;
    "Debian GNU/Linux 11")
      echo "$distribution is considered experimental but will mostly work"
      if [ "${IBRAMENU_NONINTERACTIVE:-0}" -ne 1 ]; then
        read -p "Press Enter to continue"
      fi
      ;;
    *)
      if [ "${IBRAMENU_NONINTERACTIVE:-0}" -eq 1 ]; then
        accept="y"
      else
        read -p "$distribution has not been tested, would you like to continue? (y/n) " accept
      fi
      case "$accept" in
        [yY])
          ;;
        *)
          exit 0
          ;;
      esac
      ;;
  esac

}

# Launch IBRAINSTALL
install () {
  local install_root="/opt/ibracorp"
  local installer_path="${install_root}/ibrainstall.sh"
  local installer_url="${IBRAMENU_INSTALLER_URL:-https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainstall.sh}"
  mkdir -p "$install_root"
  if [ -n "${IBRAMENU_INSTALLER_PATH-}" ]; then
    cp "$IBRAMENU_INSTALLER_PATH" "$installer_path"
  else
    wget -qO "$installer_path" "$installer_url"
  fi
  chmod +x "$installer_path"
  "$installer_path" $1
}

# Execute
if [ -z "${1-}" ]
then
  if [ "${IBRAMENU_NONINTERACTIVE:-0}" -ne 1 ]; then
    disclaimer
  fi
fi
if [ -n "${2-}" ]
then
  mkdir -p /opt/ibracorp
  echo "$2" > /opt/ibracorp/token
fi
checklist
install "${1-}"
# cleanup the initial ibrainstall
rm /opt/ibracorp/ibrainstall.sh
