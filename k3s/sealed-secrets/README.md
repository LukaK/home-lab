# sealed secrets controller

Controllers used for encrypting and managing secrets by converting them to sealed secrets.
Enables saving secrets to git repository that are encrypted with public key cryptography.

Requirements:
- kubeseal


Defaults:
- namespace: kube-system ( required by kubeseal )
- chart version: 2.15.2

#### Deployment
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

#### FAQ

How to create sealed secrets from secret file?
```
kubeseal -f secret.yaml -w sealedsecret.yaml
```

#### Annotations

```
  ...
  annotations:
    sealedsecrets.bitnami.com/namespace-wide: "true" # namespace scope of the secret
    sealedsecrets.bitnami.com/cluster-wide: "true"   # cluster wide scope of the secret ( overrides namaspece-wide )
```

