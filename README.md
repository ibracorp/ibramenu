<a href="https://ibramenu.io"><img src="/ibramenu-logo.png" align="left" height="500" width="500" ></a>

# IBRAMENU

[![Feedback](https://img.shields.io/badge/IBRAMENU-Feedback-brightgreen?style=plastic)](https://feedback.ibracorp.io/ibramenu)
[![Ubuntu](https://img.shields.io/badge/Works%20best%20with-Ubuntu-E95420?style=plastic&logo=ubuntu&logoColor=white)](https://ubuntu.com)
[![IBRADOCS](https://img.shields.io/badge/IBRA-Docs-blue?style=plastic)](https://docs.ibracorp.io)

This README is actively maintained alongside the documentation. You can also reference the
documentation page below for deeper guides and walkthroughs.

## Table of Contents

- [Installation](#installation)
- [Uninstall](#uninstall)
- [Supported Platforms & Prerequisites](#supported-platforms--prerequisites)
- [Docker Usage](#docker-usage)
- [Debug Mode](#debug-mode)
- [Network Override](#network-override)
- [Support](#support)

## Suggested Improvements & Roadmap

Below is a curated list of improvements to make IBRAMENU best-in-class for what it does.
These are grouped by impact and effort so contributors can pick quick wins or bigger initiatives.

### Quick wins (high impact, low effort)
- **Documentation refresh:** expand quickstart, troubleshooting, and upgrade notes, plus a versioned changelog.
- **Menu search & filtering:** add a searchable menu with tags (e.g., Media, Networking, Security).
- **Favorites & recent installs:** allow users to pin frequently used apps.
- **Pre-flight checks:** validate Docker/Compose availability, OS compatibility, and permissions before install.

### Medium effort improvements
- **App manifests:** define a standard `manifest.yml` for each app to generate menus and docs consistently.
- **Compose enhancements:** support health checks, resource limits, and optional security hardening profiles.
- **Network management:** create the Docker network if missing and allow custom network selection per app.
- **Debug mode & logs:** structured logging and a diagnostics command for easier support.

### Long-term initiatives
- **Release channels:** stable vs. beta channels, plus signed releases or checksums.
- **Extensible plugin system:** allow community extensions without touching core scripts.
- **CI quality gates:** ShellCheck, linting, and minimal integration tests for compose generation.

## Maintenance Status

Development has begun again, with ongoing updates focused on reliability and usability. If you're
running this in production, keep pinning versions and review updates as they land. Community
contributions are welcome.

## Installation

### As root user

```bash
wget -qO ./i https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainit.sh &&\
chmod +x i &&\
./i
```

The `ibrainit.sh` script bootstraps the install (downloads dependencies and configures the
application). Inspect it before running if you’d like, for example:

```bash
curl -L https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainit.sh | less
# or
wget -qO- https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainit.sh | less
```

### As non root user

``` bash
sudo wget -qO ./i https://raw.githubusercontent.com/ibracorp/ibramenu/main/ibrainit.sh &&\
sudo chmod +x i &&\
sudo ./i
```

## Supported Platforms & Prerequisites

### Supported OS targets
- Ubuntu 22.04 LTS (recommended)
- Ubuntu 20.04 LTS

### Minimum container tooling
- Docker Engine 24.0+
- Docker Compose plugin 2.20+

### Required tools
- `mdless` (used by pre-flight checks)
- `bash`, `curl`/`wget`, and standard GNU utilities available on Ubuntu

### Non-supported platforms
Platforms like Unraid are not officially supported. You may get IBRAMENU running via the
container workflow below, but expect limited troubleshooting support and potential feature gaps
around OS detection, permissions, and path assumptions.

## Uninstall

### As root user

```bash
/opt/ibracorp/ibramenu/ibrauninstall.sh
```

### As non root user

```bash
sudo /opt/ibracorp/ibramenu/ibrauninstall.sh
```

## Docker Usage

### From a non-supported OS like Unraid

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

### Pre-flight checks

On launch, IBRAMENU validates that Docker, the Docker Compose plugin, and `mdless` are available,
and that the Docker daemon is accessible. Fix any missing dependencies before continuing.

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

## Debug Mode

To enable additional logging, set `IBRAMENU_DEBUG=1`. Logs are written to
`/opt/appdata/ibramenu/ibramenu.log`.

## Network Override

By default IBRAMENU uses the network defined in `.profile` (`ibranet`). You can override this by
exporting `IBRAMENU_DOCKER_NETWORK` before launching the menu.

## Support

[![Install](https://img.shields.io/badge/Install-IBRAMENU-brightgreen?style=plastic)](https://docs.ibracorp.io/ibramenu)
Make requests here: <https://feedback.ibracorp.io/ibramenu>

**Want to Support Us and Get Perks?** <br>
[![Supporter](https://img.shields.io/badge/Become%20a-Supporter-brightgreen?style=plastic)](https://ibramenu.io/store/)

**Join us on Discord** <br>
[![Discord](https://img.shields.io/discord/595508571135803403?label=Discord&logo=Discord&style=plastic)](https://i.ibracorp.io/discord)
