#!/bin/bash
######################################################################
# Title   : Install Traefik
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

read -p "Your Domain (domain.com)            : " YOURDOMAIN
read -p "Your cloudflare email             : " YOUREMAIL
read -p "Your Cloudflare API token           : " CF_API_TOKEN
sudo mkdir -p /opt/appdata/Traefik
tee <<-EOF >/opt/appdata/.traefik.env
CF_DNS_API_TOKEN=$CF_API_TOKEN
DOMAIN=${YOURDOMAIN}
EMAIL=$YOUREMAIL
EOF
# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh
# source /opt/ibracorp/ibramenu/MenuOptions/Submenu Networking/Dockerproxy/Dockerproxy.sh
# Traefik config

# App Info
app="Traefik"          # App Name
title="Traefik"        # Readable App Title
image="traefik:latest" # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/etc/traefik
      - /var/run/docker.sock:/var/run/docker.sock:ro" # Volumes
tp_app=""                                             # Theme Park App Name
porte="8080"                                          # External Port
porti="8080"
porte2="443" # External Port
porti2="443"
porte3="80" # External Port
porti3="80" # Internal Port
extrapayload="    environment:
      - CF_DNS_API_TOKEN=$CF_API_TOKEN
      - CF_API_EMAIL=${YOUREMAIL}

    " # Extra Payload to add to the Compose add 4 spance to the top group for example environment: and 6 for the childs (if copy and pasting you just need to add the space to the parent).

# Execute
app
sleep 2

#create file for certificates
sudo touch /opt/appdata/Traefik/acme.json
sudo chmod 600 /opt/appdata/Traefik/acme.json

# # Create the config files

sudo tee <<-EOF >/opt/appdata/Traefik/traefik.yml
global:
  checkNewVersion: true
  sendAnonymousUsage: false

serversTransport:
  insecureSkipVerify: true

entryPoints:
  # Not used in apps, but redirect everything from HTTP to HTTPS
  http:
    address: :80
    forwardedHeaders:
      trustedIPs: &trustedIps
        # Start of Clouflare public IP list for HTTP requests, remove this if you don't use it
        - 173.245.48.0/20
        - 103.21.244.0/22
        - 103.22.200.0/22
        - 103.31.4.0/22
        - 141.101.64.0/18
        - 108.162.192.0/18
        - 190.93.240.0/20
        - 188.114.96.0/20
        - 197.234.240.0/22
        - 198.41.128.0/17
        - 162.158.0.0/15
        - 104.16.0.0/12
        - 172.64.0.0/13
        - 131.0.72.0/22
        - 2400:cb00::/32
        - 2606:4700::/32
        - 2803:f800::/32
        - 2405:b500::/32
        - 2405:8100::/32
        - 2a06:98c0::/29
        - 2c0f:f248::/32
        # End of Cloudlare public IP list
    http:
      redirections:
        entryPoint:
          to: https
          scheme: https

  # HTTPS endpoint, with domain wildcard
  https:
    address: :443
    forwardedHeaders:
      # Reuse list of Cloudflare Trusted IP's above for HTTPS requests
      trustedIPs: *trustedIps
    http:
      tls:
        # Generate a wildcard domain certificate
        certResolver: letsencrypt
        domains:
          - main: ${YOURDOMAIN}
            sans:
              - '*.${YOURDOMAIN}'
      middlewares:
        - securityHeaders@file

providers:
  providersThrottleDuration: 2s

  # File provider for connecting things that are outside of docker / defining middleware
  file:
    filename: /etc/traefik/fileConfig.yml
    watch: true

  # Docker provider for connecting all apps that are inside of the docker network
  docker:
    watch: true
    network: ${dockernet} # Add Your Docker Network Name Here
    # Default host rule to containername.domain.example
    defaultRule: "Host(\`{{ index .Labels \"com.docker.compose.service\"}}.${YOURDOMAIN}\`)" # Make sure to check the guide if it is blank
    swarmModeRefreshSeconds: 15s
    exposedByDefault: false
    #endpoint: "tcp://Dockerproxy:2375" # Uncomment if you are using docker socket proxy
    endpoint: "unix:///var/run/docker.sock" # comment if using docker socket proxy

# Enable traefik ui
api:
  dashboard: true
  # insecure: true # uncomment if you want to access the dashboard in the local network, make sure you have some type of auth for the reverse proxy

# Log level INFO|DEBUG|ERROR
log:
  level: DEBUG

# Use cloudflare to generate ssl serficiates
certificatesResolvers:
  letsencrypt:
    acme:
      email: ${YOUREMAIL}
      storage: /etc/traefik/acme.json
      caServer: https://acme-staging-v02.api.letsencrypt.org/directory # comment this after you are able to get a certificate
      #caServer: "https://acme-v02.api.letsencrypt.org/directory" # uncomment this after you are able to get a certificate to use in production
      dnsChallenge:
        provider: cloudflare
        delayBeforeCheck: 60 # comment this after you are able to get a certificate
        disablePropagationCheck: true # uncomment this if you have issues pulling certificates through cloudflare, By setting this flag to true disables the need to wait for the propagation of the TXT record to all authoritative name servers.
        # Used to make sure the dns challenge is propagated to the rights dns servers
        resolvers:
          - "1.1.1.1:53"
          - "1.0.0.1:53"
EOF

sudo tee <<-EOF >/opt/appdata/Traefik/fileConfig.yml
http:

  # EXTERNAL ROUTING EXAMPLE - Only use if you want to proxy something manually ##cd ..
  routers:
    # # Homeassistant routing example - Remove if not used
    # homeassistant:
    #   entryPoints:
    #     - https
    #   rule: "Host(\`homeassistant.${YOURDOMAIN}\`)" # make sure to chek the guide if and add your domain if blank
    #   service: homeassistant
    #   middlewares:
    #     - "auth"

    #   # api uncomment to reverse proxy the dashboard, this config use authelia
    # api:
    #   entryPoints:
    #     - https
    #   rule: "Host(\`traefik.${YOURDOMAIN}\`)" # make sure to chek the guide if and add your domain if blank
    #   service: api@internal
    #   middlewares:
    #     - "auth"

  # ## SERVICES EXAMPLE ##
  # services:
  #   # Homeassistant service example - Remove if not used
  #   homeassistant:
  #     loadBalancer:
  #       servers:
  #         - url: http://192.168.60.5:8123/

  ## MIDDLEWARES ##
  middlewares:
    # Only Allow Local networks
    local-ipwhitelist:
      ipWhiteList:
        sourceRange:
          - 127.0.0.1/32 # localhost
          - 192.168.1.1/24 # LAN Subnet

    # # Authelia guard
    # auth:
    #   forwardauth:
    #     address: http://auth:9091/api/verify?rd=https://auth.${YOURDOMAIN}/ # replace auth with your authelia container name
    #     trustForwardHeader: true
    #     authResponseHeaders:
    #       - Remote-User
    #       - Remote-Groups
    #       - Remote-Name
    #       - Remote-Email

    # # Authelia basic auth guard
    # auth-basic:
    #   forwardauth:
    #     address: http://auth:9091/api/verify?auth=basic # replace auth with your authelia container name
    #     trustForwardHeader: true
    #     authResponseHeaders:
    #       - Remote-User
    #       - Remote-Groups
    #       - Remote-Name
    #       - Remote-Email

    # Security headers
    securityHeaders:
      headers:
        customResponseHeaders:
          X-Robots-Tag: "none,noarchive,nosnippet,notranslate,noimageindex"
          server: ""
          X-Forwarded-Proto: "https"
        sslProxyHeaders:
          X-Forwarded-Proto: https
        referrerPolicy: "strict-origin-when-cross-origin"
        hostsProxyHeaders:
          - "X-Forwarded-Host"
        customRequestHeaders:
          X-Forwarded-Proto: "https"
        contentTypeNosniff: true
        browserXssFilter: true
        forceSTSHeader: true
        stsIncludeSubdomains: true
        stsSeconds: 63072000
        stsPreload: true

# Only use secure ciphers - https://ssl-config.mozilla.org/#server=traefik&version=2.6.0&config=intermediate&guideline=5.6
tls:
  options:
    default:
      minVersion: VersionTLS12
      cipherSuites:
        - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
        - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        - TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        - TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305
        - TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305
EOF
