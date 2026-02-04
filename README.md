<a href="https://ibramenu.io"><img src="/ibramenu-logo.png" align="left" height="500" width="500" ></a>

# IBRAMENU

[![Feedback](https://img.shields.io/badge/IBRAMENU-Feedback-brightgreen?style=plastic)](https://feedback.ibracorp.io/ibramenu)
[![Ubuntu](https://img.shields.io/badge/Works%20best%20with-Ubuntu-E95420?style=plastic&logo=ubuntu&logoColor=white)](https://ubuntu.com)
[![IBRADOCS](https://img.shields.io/badge/IBRA-Docs-blue?style=plastic)](https://docs.ibracorp.io)

This README is a work in progress and awaiting other tasks before being completed.
The actual documentation page below has all the information to help you get started with IBRAMENU.

## Maintenance Status

This project has not had code updates in several years. If you're relying on it in production,
please consider pinning versions, reviewing install/update scripts, and validating dependencies
against your current OS and Docker versions before deploying. Community contributions are welcome.

## HOW TO INSTALL

### As root user

```bash
wget -qO ./i https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainit.sh &&\ 
chmod +x i &&\ 
./i
```

### As non root user

``` bash
sudo wget -qO ./i https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainit.sh &&\ 
sudo chmod +x i &&\ 
sudo ./i
```

### From a non supported OS like unraid

This is not supported and a WIP. Run the following commands.

```bash
git clone -b main --single-branch https://github.com/ibracorp/ibramenu.git
cd ibramenu
docker compose up -d --build --force-recreate
```

### Access the container

To generate the docker compose file for your apps you need to run ibramenu from within the container, run the following command.

```bash
docker run -it ibramenu /bin/bash
```

### Compose File Example

Change the `/opt/appdata` to the location that you want your docker files to be generated to.

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
#### Open Ibramenu inside the container
- Run the following command to open and shell

```sh
docker exec -it ibramenu bash
```
- In the shell that opens run the following command to start ibramenu

```sh
ibramenu
```




[![Install](https://img.shields.io/badge/Install-IBRAMENU-brightgreen?style=plastic)](https://docs.ibracorp.io/ibramenu)
Make requests here: <https://feedback.ibracorp.io/ibramenu>

**Want to Support Us and Get Perks?** <br>
[![Supporter](https://img.shields.io/badge/Become%20a-Supporter-brightgreen?style=plastic)](https://ibramenu.io/store/)

**Join us on Discord** <br>
[![Discord](https://img.shields.io/discord/595508571135803403?label=Discord&logo=Discord&style=plastic)](https://i.ibracorp.io/discord)
