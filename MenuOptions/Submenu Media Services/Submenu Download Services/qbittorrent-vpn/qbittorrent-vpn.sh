#!/bin/bash
######################################################################
# Title   : Install SABnzbd
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# Record lan ip to access WEBUI
read -p "Enter you lan Network EX. (192.168.1.0/24)            : " IP

# App Info
app="qbittorrent-vpn"                                  # App Name
title="qbittorrent-vpn"                                # Readable App Title
image="cr.hotio.dev/hotio/qbittorrent"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config
      - /mnt/media:/media"                     # Volumes
tp_app="qbittorrent"                                # Theme Park App Name
porte="8080"                                   # External Port
porti="8080"                                   # Internal Port
extrapayload="    environment:
      - net.ipv6.conf.all.disable_ipv6=1
      - VPN_LAN_NETWORK=${IP} 
      - VPN_ADDITIONAL_PORTS=7878/tcp,9117/tcp " # for additional ports, Ex. Wanting to route traffic from other containers over the vpn

# Execute
app
sudo touch /opt/appdata/\${APP_NAME:?err}/wg0.conf

sudo tee <<-EOF > /opt/appdata/\${APP_NAME:?err}/wg0.conf
[Interface]
PrivateKey = supersecretprivatekey
Address = xx.xx.xxx.xxx/32
DNS = 1.1.1.1

[Peer]
PublicKey = publickey
AllowedIPs = 0.0.0.0/0
Endpoint = xxx.x.xxx.x:51820
EOF