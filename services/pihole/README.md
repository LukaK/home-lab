# pihole

Defaults:
- namespace: pihole
- chart version: 2.22.0

#### Deployment
```
# search for compatible version
make show_versions

# update chart version in makefile if necessary (CHART_VERSION)
vi Makefile

# build new manifest file for a version
make

# install pihole
make install
```
