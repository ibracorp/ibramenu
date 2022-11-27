#!/bin/bash
######################################################################
# Title   : IBRAFUNC - IBRAMENU functions
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# functions

# message box
msgbox () {
  # function expects a message and optional parameters
  # msgbox <Text> <width of box> <horizontal character for the box> <vertical character for the box>
  # If the box parameters are not given the full width will be used and = for horizontal and | for vertical character

  # checking if message is specified
  if [[ -z $1 ]]; then
    message="Your message could be here"
  else
    message=$1
  fi
  # checking if message box width is specified
  if [[ -z $2 ]]; then
    box_width=$(tput cols)
  else
    box_width=$2
  fi
  # checking if horizontal character is specified
  if [[ -z $3 ]]; then
    box_hor="="
  else
    box_hor=$3
  fi
  # checking if vertical charater is specified
  if [[ -z $4 ]]; then
    box_vert="|"
  else
    box_vert=$4
  fi
  # calculating message box parameters
  msg_length=${#message}
  msg_half=$(( $msg_length / 2 ))
  msg_start=$(( ( ( $box_width - 2 ) / 2 ) - $msg_half ))
  msg_fill_left=$(( $msg_start ))
  msg_fill_right=$(( ( $box_width - 2 ) - $msg_start - $msg_length ))
  # generating strings for box
  box_outline_hor=$(printf %"$box_width"s | tr ' ' "$box_hor")
  msg_space_left=$(printf %"$msg_fill_left"s)
  msg_space_right=$(printf %"$msg_fill_right"s)
  # output
  echo
  echo $box_outline_hor
  echo "$box_vert$msg_space_left$message$msg_space_right$box_vert"
  echo $box_outline_hor
  echo
}

# ibracorp logo
ibralogo () {
  version=$(cat "/opt/ibracorp/ibramenu/version")
  tput clear
  tput bold
  tput setaf 1
  tee <<-EOF
  ___ ____  ____      _    ____ ___  ____  ____  ™ 
 |_ _| __ )|  _ \    / \  / ___/ _ \|  _ \|  _ \  
  | ||  _ \| |_) |  / _ \| |  | | | | |_) | |_) | 
  | || |_) |  _ <  / ___ \ |__| |_| |  _ <|  __/  
 |___|____/|_| \_\/_/   \_\____\___/|_| \_\_|     RC2 Version $version
                                                 
$(lsb_release -sd) | CPU Threads: $(lscpu | grep "CPU(s):" | tail +1 | head -1 | awk  '{print $2}') | IP: $(hostname -I | awk '{print $1}') | RAM: $(free -m | grep Mem | awk 'NR=1 {print $2}') MB
Become a Member and sponsor us: https://ibracorp.io/memberships
EOF
  tput sgr0
}

# disclaimer
disclaimer () {
  ibralogo

  if [ -f "/opt/ibracorp/IBRADISCLAIMER" ]
  then
    if grep -q "IBRADISCLAIMER=accepted" "/opt/ibracorp/IBRADISCLAIMER"
    then
      :
      # Has already been accepted
    else
      rm "/opt/ibracorp/IBRADISCLAIMER"
      exit
    fi
  else
    tee <<-EOF
Please take a moment and read our IBRACORP Disclaimer:
https://docs.ibracorp.io/ibracorp/
EOF
    read -p "Do you accept our Disclaimer? y/N: " accept

    case "$accept" in
      [yY])
        echo "Thank you for accepting the IBRACORP Disclaimer."
        echo
        stamp=$(date)
        tee <<-EOF > /opt/ibracorp/IBRADISCLAIMER
IBRADISCLAIMER=accepted
$stamp
EOF
          ;;
      *)
        echo "IBRACROP Disclaimer has not been accepted. Exiting..."
        echo
        exit 0
          ;;
    esac
  fi
}

environment_check () {
  # Check for environment files or otherwise create them with defaults
  if [ ! -d "/opt/appdata" ]
  then
    mkdir -p /opt/appdata
  fi
  # Timezone
  if [ ! -f "/opt/appdata/.timezone.env" ]
  then
    echo "TZ=UTC" > "/opt/appdata/.timezone.env"
  fi
  # PUID and PGID
  if [ ! -f "/opt/appdata/.id.env" ]
  then
    echo "PUID=1000" > "/opt/appdata/.id.env"
    echo "PGID=1000" >> "/opt/appdata/.id.env"
  fi
  # theme.park
  if [ ! -f "/opt/appdata/.themepark.env" ]
  then
    echo "DOCKER_MODS=ghcr.io/gilbn/theme.park:\${TP_APP}" > "/opt/appdata/.themepark.env"
    echo "TP_THEME=plex" >> "/opt/appdata/.themepark.env"
  fi
}

# launch docker compose container
launchdocker () {
  target_folder=$1
  if [ ! -d $target_folder ]; then
    mkdir -p "$target_folder"
  fi
  cp -R * "$target_folder"
  docker compose -f "$target_folder/compose.yaml" up -d
}

# display README.md
readme () {
  if [ -f "README.md" ]
  then
    mdless -P "README.md"
    read -p "Do you want to continue (y)? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      return
    else
      return 1
    fi
  fi
}

# check if ibramenu is up-to-date
checkupdate () {
  version=$(cat "/opt/ibracorp/ibramenu/version")
  current=$(curl -s https://raw.githubusercontent.com/ibracorp/ibramenu/main/version)
  if [ ! $version = $current ]
  then
    msgbox "You IBRAMENU is not up-to-date. Use 'ibraupdate' to update."
  fi
}

# IBRACORP motd
ibramotd () {
  chmod -x /etc/update-motd.d/*
  tee <<-'EOF' > /etc/update-motd.d/01-ibracorp
#!/bin/bash
######################################################################
# Title   : IBRACORP MOTD
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP   ^d
######################################################################
tee <<-EOF
  ___ ____  ____      _    ____ ___  ____  ____     (tm)
 |_ _| __ )|  _ \    / \  / ___/ _ \|  _ \|  _ \  
  | ||  _ \| |_) |  / _ \| |  | | | | |_) | |_) | 
  | || |_) |  _ <  / ___ \ |__| |_| |  _ <|  __/  
 |___|____/|_| \_\/_/   \_\____\___/|_| \_\_|     
$(lsb_release -sd) | CPU Threads: $(lscpu | grep "CPU(s):" | tail +1 | head -1 | awk  '{print $2}') | IP: $(hostname -I | awk '{print $1}') | RAM: $(free -m | grep Mem | awk 'NR=1 {print $2}') MB
Become a Member and sponsor us: https://ibracorp.io/memberships
Type 'ibramenu' to launch IBRAMENU.
EOF
  echo "EOF" >> /etc/update-motd.d/01-ibracorp
  chmod +x /etc/update-motd.d/01-ibracorp
}
