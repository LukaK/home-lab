# media server

Technologies:
- prowlarr: torrent site indexing
- radarr: movie management
- sonarr: tv series management
- transmission: torrent download client

Defaults:
- prowlarr.media.cluster.local: prowlarr url
- radarr.media.cluster.local: radarr url
- sonarr.media.cluster.local: sonarr url
- transmission.media.cluster.local: transmission url


## Deployment

Requirements:
- k3s cluster deployed and configured
- make sure that `.cluster.loca` subdomain resolves to ingress controlelr

```
# deploy resources
make && make install
```

## prowlarr

Configuration settings for radarr and sonarr is in `settings -> apps`.
Configuration settings for transmission client is in `settings -> download client`

Radarr configuration:
- go to `radarr.media.cluster.local -> settings -> general` and copy token to prowlarr `API Key` field
- change `Prowlarr Server: http://prowlarr:9696`
- change `Radarr Server: http://radarr:80`

Sonarr configuration:
- go to `sonarr.media.cluster.local -> settings -> general` and copy token to prowlarr `API Key` field
- change `Prowlarr Server: http://prowlarr:9696`
- change `Sonarr Server: http://sonarr:80`

Transmission configuration:
- change `Host: transmission`
- change `Port: 80`

## radarr configuration
Configuration settings for transmission client is in `settings -> download clients`

Configuration:
- go to `Settings -> Media Management` and update root folder to `/movies`

Transmission configuration:
- change `Host: transmission`
- change `Port: 80`


## sonarr configuration
Configuration settings for transmission client is in `settings -> download clients`

Configuration:
- go to `Settings -> Media Management` and update root folder to `/tv`

Transmission configuration:
- change `Host: transmission`
- change `Port: 80`


## transmission configuration
Configuration:
- change complted directory to `/downloads/transmission`
