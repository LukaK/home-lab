# ingress controller

Ingress controller used as reverse proxy.

Features:
- tls termination
- layer 7 load balancing

Defaults:
- namespace: ingress-nginx
- chart version: 4.10.0

## Deployment

```
# search for compatible version
make show_versions

# update chart version in makefile if necessary (CHART_VERSION)
vi Makefile

# build new manifest file for a version
make

# install nginx ingress controller
make install
```

## Examples

```
pushd examples

# create sealed secret
kubectl apply -f ingress-with-tls.yaml

# check that resources are deployed
kubectl get all
kubectl get ingress

# update name resolution
sudo vi /etc/hosts   # add <ip of matallb> test.cluster.lab

# test secure connection: go to https://test.cluster.lab

# cleanup
kubectl delete -f ingress-with-tls.yaml
```
