# cert-manager with self-signed ssl certificates

Certificate manager used for issuing certificates for ingress controller.

How to setup cert manager:
- generate intermediate certificate and key
- create `nginx-ca-secret.yaml` from template file and add base64 encoded cert and key values
- deploy secret and `cluster-issuer.yaml` resources
- ensure that dns redirects cluster resources to nginx ingress ontroller ip

Defaults:
- namespace: cert-manager
- chart version: v1.14.4

#### Deployment
```
# search for compatible version
make show_versions

# update chart version in makefile if necessary (CHART_VERSION)
vi Makefile

# build new manifest file for a version
make

# download intermediate certificate from ca server
cp nginx-ca-secret.template.yaml manifests/ca-secret.yaml && vi manifests/nginx-ca-secret.yaml

# install nginx ingress controller ( TODO: needs wait conditions kubectl wait)
make install
```
