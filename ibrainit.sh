#!/bin/bash

######################################################################
# Title   : Beachhead - Initial Installer for IBRAMENU
# By      : DiscDuck
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
  read -p "Press Enter to continue"
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
      ;;
    *)
      read -p "$distribution has not been tested, would you like to continue? (y/n) " accept
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
  apt update
  apt install sudo
  mkdir -p /opt/ibracorp
  wget -qO /opt/ibracorp/ibrainstall.sh https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainstall.sh
  chmod +x /opt/ibracorp/ibrainstall.sh
  /opt/ibracorp/ibrainstall.sh
}

# Execute
disclaimer
checklist
install
