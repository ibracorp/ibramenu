#!/bin/bash
######################################################################
# Title   : Basic Docker Control
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# Greetings
greetings () {
    ibralogo
    msgbox "Basic Docker Controls"
}

# Docker Control Menu
docker_control_menu () {
    tee <<-EOF
Basic Docker Control Menu

1. Stop all Docker Container
2. Start all Docker Container (up -d)
3. Execute your own command

EOF
    read -p "Enter Number (1-3) and press Enter: " choice
    case $choice in
        1)
            msgbox "Stopping all Docker Container"
            docker_control "stop"
            ;;
        2)
            msgbox "Starting all Docker Container"
            docker_control "up -d"
            ;;
        3)
            msgbox "Execute your own Docker Container command"
            tee <<-EOF
Examples:

config                  = Validate and view the Compose file
down                    = Stop and remove containers, networks, images, and volumes
pause                   = Pause services
port                    = Print the public port for a port binding
ps                      = List containers
restart                 = Restart services
rm                      = Remove stopped containers
start                   = Start services
unpause                 = Unpause services
up -d --force-recreate  = Recreate containers
convert                 = Show compose

EOF
            read -p "Enter command to be executed (plain and without \")? " docker_command
            docker_control $docker_command
            ;;
        *)
            echo "Not a valid choice..."
            ;;
    esac
}

# Docker Control Execute
docker_control () {
    store_folder=$(pwd)
    cd /opt/appdata
    for file in *; do
        msgbox "Docker Container $file"
        docker_c=("$docker_c[@]}" "$file")
        if [ -d "$file" ]; then
            cd $file
            docker compose $1
            cd ..
        fi
    done
    cd "$store_folder"
}

# Execute
greetings
docker_control_menu
