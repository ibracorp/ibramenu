#!/bin/bash
######################################################################
# Title   : Install Unpackerr
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="unpackerr"                                  # App Name
title="unpackerr"                                # Readable App Title
image="golift/unpackerr"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config
      - /mnt/media:/media" # Volumes
tp_app="unpackerr"                               # Theme Park App Name
porte=""                                    # External Port
porti=""                                    # Internal Port
extrapayload="    environment:
      - TZ=${TZ}
      # General config
      - UN_DEBUG=false
      - UN_LOG_FILE=
      - UN_LOG_FILES=10
      - UN_LOG_FILE_MB=10
      - UN_INTERVAL=2m
      - UN_START_DELAY=1m
      - UN_RETRY_DELAY=5m
      - UN_MAX_RETRIES=3
      - UN_PARALLEL=1
      - UN_FILE_MODE=0644
      - UN_DIR_MODE=0755
      # Sonarr Config
      - UN_SONARR_0_URL=http://sonarr:8989
      - UN_SONARR_0_API_KEY=
      - UN_SONARR_0_PATHS_0=/media/torrents
      - UN_SONARR_0_PROTOCOLS=torrent
      - UN_SONARR_0_TIMEOUT=10s
      - UN_SONARR_0_DELETE_ORIG=false
      - UN_SONARR_0_DELETE_DELAY=5m
      # Radarr Config
      - UN_RADARR_0_URL=http://radarr:7878
      - UN_RADARR_0_API_KEY=
      - UN_RADARR_0_PATHS_0=/media/torrents
      - UN_RADARR_0_PROTOCOLS=torrent
      - UN_RADARR_0_TIMEOUT=10s
      - UN_RADARR_0_DELETE_ORIG=false
      - UN_RADARR_0_DELETE_DELAY=5m
      # # Lidarr Config
      # - UN_LIDARR_0_URL=http://lidarr:8686
      # - UN_LIDARR_0_API_KEY=
      # - UN_LIDARR_0_PATHS_0=/media/torrents
      # - UN_LIDARR_0_PROTOCOLS=torrent
      # - UN_LIDARR_0_TIMEOUT=10s
      # - UN_LIDARR_0_DELETE_ORIG=false
      # - UN_LIDARR_0_DELETE_DELAY=5m
      # # Readarr Config
      # - UN_READARR_0_URL=http://readarr:8787
      # - UN_READARR_0_API_KEY=
      # - UN_READARR_0_PATHS_0=/media/torrents
      # - UN_READARR_0_PROTOCOLS=torrent
      # - UN_READARR_0_TIMEOUT=10s
      # - UN_READARR_0_DELETE_ORIG=false
      # - UN_READARR_0_DELETE_DELAY=5m
      # # Folder Config
      # - UN_FOLDER_0_PATH=
      # - UN_FOLDER_0_EXTRACT_PATH=
      # - UN_FOLDER_0_DELETE_AFTER=10m
      # - UN_FOLDER_0_DELETE_ORIGINAL=false
      # - UN_FOLDER_0_DELETE_FILES=false
      # - UN_FOLDER_0_MOVE_BACK=false
      # # Webhook Config
      # - UN_WEBHOOK_0_URL=
      # - UN_WEBHOOK_0_NAME=
      # - UN_WEBHOOK_0_NICKNAME=Unpackerr
      # - UN_WEBHOOK_0_CHANNEL=
      # - UN_WEBHOOK_0_TIMEOUT=10s
      # - UN_WEBHOOK_0_SILENT=false
      # - UN_WEBHOOK_0_IGNORE_SSL=false
      # - UN_WEBHOOK_0_EXCLUDE_0=
      # - UN_WEBHOOK_0_EVENTS_0=0
      # - UN_WEBHOOK_0_TEMPLATE_PATH=
      # - UN_WEBHOOK_0_CONTENT_TYPE=application/json
      # # Command Hook Config
      # - UN_CMDHOOK_0_COMMAND=
      # - UN_CMDHOOK_0_NAME=
      # - UN_CMDHOOK_0_TIMEOUT=10s
      # - UN_CMDHOOK_0_SILENT=false
      # - UN_CMDHOOK_0_SHELL=false
      # - UN_CMDHOOK_0_EXCLUDE_0=
      # - UN_CMDHOOK_0_EVENTS_0=0"                                 # Extra Payload to add to the Compose

# Execute
app