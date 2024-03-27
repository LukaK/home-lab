# sealed secrets


Controller used for encrypting and managing secrets by encrypting sensitive data with public key cryptography and converting secrets to sealed secrets.
This enables users to store secret data in repositories for easy access and automation.
When a sealed secret is created it can only be decrypted by the sealed secret controller.

Features:
- asymetric encryption of secret data
- automatic key renewal

### Access controll
To ensure security controlls, sealed secrets, once created, by default can't change name or namespace.
To change that behavior you change the scope of the sealed secret.

Scopes:
- strict (default): name and namespace are part of the encrypted data. Changing sealed secret name or namespace results in decryption error
- `namespace-wide`: you can freely rename the sealed secret within a given namespace
- `cluster-wide`: the secret can be unsealed in any namespace and can be given any name


```
  # annotations
  ...
  annotations:
    # namespace scope of the secret
    sealedsecrets.bitnami.com/namespace-wide: "true"

    # cluster wide scope of the secret ( overrides namaspece-wide )
    sealedsecrets.bitnami.com/cluster-wide: "true"
```


### Creating new sealed secret

Sealed secrets are created from secret definitions.

```
# creating sealed secret
kubeseal -f secret.yaml -w sealedsecret.yaml
kubeseal -f secret.yaml > sealedsecret.yaml
```

### Moving existing secret to a sealed secret

If you want to move existing secret to a sealed secret, annotate the existing secret with `sealedsecrets.bitnami.com/managed: "true"`.
Once a sealed secret with the same name and namespace is created, existing secret will be overwritten and sealed secret controller will take ownership.


### Key rotation
Controller renews the keys automatically but leaves old keys to decrypt secrets that where encrypted with them.
It is recommended to periodically generate sealed secrets that are encrypted with new keys.

Key renewal does not substitute the rotation of secret values in a sealed secret.

```
# reincrypting sealed secret
cat <sealed secret>.yaml | kubeseal --re-encrypt -o yaml > <sealed secret>.yaml
```


### Migrating secrets to a new cluster

Once sealed secret is created, only sealed secret controller can decrypt the sealed secret.
To do that it needs access to the private key that is used to encrypt the secret.

To move secrets to a new cluster you need to migrate private keys of sealed secrets controller.

```
# list private keys used by the controlelr
kubectl get secrets -n kube-system

# backup private keys
kubectl get secret -n kube-system \
    -l sealedsecrets.bitnami.com/sealed-secrets-key \
    -o yaml \
    > sealed-secret-keys.key

# move private keys to the new cluster and restart the controler pod
kubectl apply -f sealed-secret-keys.key
kubectl delete pod -n kube-system <sealed secret controller>
```


## Installation
To install sealed secrets you need sealed secrets controller and `kubeseal` cli.
Default namespace for the controller that is expected from `kubeseal` is `kube-system`.
Use your distribution package manager to install `kubeseal` utility.

#### Installing the controller

Defaults:
- namespace: kube-system ( required by kubeseal )
- chart version: 2.15.2

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
kubeseal -f secret.yaml -w sealedsecret.yaml

# create sealed secret
kubectl apply -f sealedsecret.yaml

# check that the secret is created
kubectl get secret
kubectl get sealedsecretsecret

# cleanup
kubectl delete -f sealedsecret.yaml
```
