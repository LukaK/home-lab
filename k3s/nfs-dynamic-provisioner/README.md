# nfs dynamic provisioner

Dynamic nfs provisioner used for provisioning persistent volumes dynamically on nfs server.

Create nfs share on synology nas:
- control panel -> shared folder -> create
- add admin read/write permissions and accet default options
- edit nfs share -> nfs permissions -> create
- add ip subnet
- update squash map to elevate users to admins ( avoid for now, mount directory permissions mismatch when container is running as non root )
- check allow non privilaged ports
- check allow users to access subdirectories

K3s node requirements:
- `sudo apt install nfs-common`

Defaults:
- namespace: nfs-provisioner
- chart version: 4.0.18

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
kubectl apply -f pvc.yaml

# check that pv and pvc are created
kubectl get pv
kubectl get pvc

# cleanup
kubectl delete -f pvc.yaml
```
