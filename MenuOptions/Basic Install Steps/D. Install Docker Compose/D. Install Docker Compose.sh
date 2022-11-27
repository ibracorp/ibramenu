#!/bin/bash

######################################################################
# Title   : Install Docker Compose
# By      : ibros
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

install_docker_compose () {
   mkdir -p ~/.docker/cli-plugins/
   curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
   chmod +x ~/.docker/cli-plugins/docker-compose
   ## install compose switch - https://docs.docker.com/compose/cli-command/#compose-switch
   curl -fL https://raw.githubusercontent.com/docker/compose-cli/main/scripts/install/install_linux.sh | sh 
   docker compose version
}

install_docker_compose
