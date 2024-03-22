# ingress controller

Ingress controller used for url path routing to cluster services.

Details:
- namespace: ingress-nginx
- default chart version: 4.10.0

#### Deployment

```
# search for compatible version
make show_versions

# update chart version in makefile if necessary (CHART_VERSION)
vi Makefile

# build new manifest file for a version
make template

# deploy nginx ingress controller
make deploy
```
