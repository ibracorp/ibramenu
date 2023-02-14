#!/bin/bash

######################################################################
# Title   : Install General Tools
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

install_tools () {
   # Update catalog
   apt update
   # Unzip
   apt install unzip -y
   # Python 3 (pip)
   apt install python3-pip -y
   # Pip psutil
   apt-get install gcc python3-dev
   pip install --no-binary :all: psutil
   # Google Download
   pip3 install gdown
   # dos2unix to fix CRLF
   apt install dos2unix -y
   # glances monitoring tool
   apt install glances -y
   # tmux
   apt install tmux -y
   # zsh
   apt install zsh -y
   # midnight commander
   apt install mc -y
}

install_tools
