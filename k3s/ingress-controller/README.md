# ingress controller

Ingress controller used for url path routing to cluster services.

How to deploy nginx ingress controller:
* find chart version compatible with kubernetes version
* create namespace for ingress controller
* install ingress from specified path version

```
# install nginx ingress controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# get kubernetes version
kubectl version

# get chart version
helm search repo ingress-nginx --versions

# create namespace
kubectl create namespace ingress-nginx

# install ingress controller
CHART_VERSION="4.10.0"
helm install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --version ${CHART_VERSION} \
  --namespace ingress-nginx \
  --values ingress-nginx-values.yaml

```
