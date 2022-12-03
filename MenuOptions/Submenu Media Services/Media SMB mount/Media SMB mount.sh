#!/bin/bash

######################################################################
# Title   : Create Media SMB mount
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# Greetings
greetings () {
  ibralogo
  msgbox "Media SMB mount"
}

# Parameters
parameters () {
  msgbox "Setting Parameters for Your Setup"
  tee <<-EOF
We will now automatically create your Media SMB mount.

It will work with Media Server Services from IBRAMENU like
* Plex * Sonarr * Radarr * Prowlarr * SABnzbd *

After we gathered information about your Storage setup, we will
setup the mount to your Storage Server.

You will now be asked the following questions:
Your Storage Server Username and Password
The Storage Server Address like "192.168.0.1" or "storage.local"
The Share name where your media is located, like "media"

Please enter all parameters without any "".

EOF
  read -p "Username for your storage server: " username
  read -sp "Password for that user (input will not show): " password
  echo
  read -p "The address of your storage server: " storage_server
  read -p "The share name for media: " storage_share
}

# Storage Mount
storage_mount () {
  msgbox "Installing CIFS/SMB Utilities and creating the Mount"
  sleep 2
  apt install cifs-utils -y
  fstorage_share=${storage_share//[ ]/\\040}
  tee <<-EOF > /root/.storage_credentials
username=$username
password=$password
EOF
  mkdir -p /mnt/media
  tee <<-EOF > /etc/fstab
#media
//$storage_server/$fstorage_share /mnt/media       cifs    noperm,iocharset=utf8,rw,credentials=/root/.storage_credentials,uid=root,gid=root,file_mode=0660,dir_mode=0770 0       0
EOF
  mount -a
}

# Finalization

finalization () {
  sleep 3
  ibralogo
  msgbox "All Done!"
  echo
  echo "Your media mount is now available under /mnt/media"
  echo
  echo "All IBRAMENU Media player, ARRs and download services will be using the mount out of the box."
  echo
}

# Execute
greetings
parameters
storage_mount
finalization