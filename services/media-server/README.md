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
# add secrets file services-secret.yaml
# get plex claim on https://plex.tv/claim
cp services-secret.template.yaml services-secret.yaml
echo -n 'claim' | base64 -w0 >> services-secret.yaml
vi services-secret.yaml

# deploy resources
make install
```

## prowlarr

Configuration settings for radarr and sonarr is in `settings -> apps`.
Add indexes.

Radarr configuration:
- go to `radarr.media.cluster.lab -> settings -> general` and copy token to prowlarr `API Key` field
- change `Prowlarr Server: http://prowlarr:9696`
- change `Radarr Server: http://radarr:7878`

Sonarr configuration:
- go to `sonarr.media.cluster.lab -> settings -> general` and copy token to prowlarr `API Key` field
- change `Prowlarr Server: http://prowlarr:9696`
- change `Sonarr Server: http://sonarr:8989`

## radarr configuration
Configuration settings for transmission client is in `settings -> download clients`

Configuration:
- go to `Settings -> Media Management`, update root folder to `/data/library/movies` and enable import of extra files with advanced
- go to `Settings -> Metadata` and activate metadata collection
- go to `Settings -> General -> Analytics` and disable analytics collection
- go to `Settings -> Profiles` and update profiles

Transmission configuration:
- change `Host: transmission`
- change `Port: 9091`
- change mapping so that `/downloads` points to `/data/downloads`


## sonarr configuration
Configuration settings for transmission client is in `settings -> download clients`

Configuration:
- go to `Settings -> Media Management` and update root folder to `/data/library/tv`
- go to `Settings -> metadata` and update activate creation of metadata for plex
- go to `Settings -> General -> Analytics` and disable analytics collection
- go to `Settings -> Profiles` and update profiles

Transmission configuration:
- change `Host: transmission`
- change `Port: 9091`
- change mapping so that `/downloads` points to `/data/downloads`


## plex configuration
Configuration:
- go to `Settings -> Authorized devices` and remove old plex server if it is deplicated
- add movie and show library
- go to `Settings -> Library -> Scan my library automatically`

## pfsense configuration
- Firewall > NAT > Port Forward
- add forwarding rules for the tv to the cluster metallb of ingress controller ( 10.0.10.82 )

## TODO
- add vpn support
- transcoder for plex, passing video card to docker worker and taints
- fix delete between transmission and sonarr/radarr
- add security context for containers to run as normal users
- add instructions how to setup firewall and stream it on local network
