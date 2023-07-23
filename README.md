<a href="https://ibramenu.io"><img src="/ibramenu-logo.png" align="left" height="500" width="500" ></a>

# IBRAMENU

[![Feedback](https://img.shields.io/badge/IBRAMENU-Feedback-brightgreen?style=plastic)](https://feedback.ibracorp.io/ibramenu)
[![Ubuntu](https://img.shields.io/badge/Works%20best%20with-Ubuntu-E95420?style=plastic&logo=ubuntu&logoColor=white)](https://ubuntu.com)
[![IBRADOCS](https://img.shields.io/badge/IBRA-Docs-blue?style=plastic)](https://docs.ibracorp.io)

This README is a work in progress and awaiting other tasks before being completed.
The actual documentation page below has all the information to help you get started with IBRAMENU.

**HOW TO INSTALL** <br>

As root user
`wget -qO ./i https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainit.sh && chmod +x i && ./i`

As non root user
`sudo wget -qO ./i https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainit.sh && sudo chmod +x i && sudo ./i`

**Compose File Example** <br>
```yaml
---
services:
  ibramenu:
    image: ibramenu:v0.0.0-1alpha
    container_name: ibramenu
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/EST
    volumes:
      - /opt/appdata:/opt/appdata
      - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped
```

[![Install](https://img.shields.io/badge/Install-IBRAMENU-brightgreen?style=plastic)](https://docs.ibracorp.io/ibramenu)
Make requests here: https://feedback.ibracorp.io/ibramenu

**Want to Support Us and Get Perks?** <br>
[![Supporter](https://img.shields.io/badge/Become%20a-Supporter-brightgreen?style=plastic)](https://ibramenu.io/store/)

**Join us on Discord** <br>
[![Discord](https://img.shields.io/discord/595508571135803403?label=Discord&logo=Discord&style=plastic)](https://i.ibracorp.io/discord)
