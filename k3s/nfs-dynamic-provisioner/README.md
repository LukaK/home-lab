# nfs dynamic provisioner

create nfs share on synology nas:
- control panel -> shared folder -> create
- add admin read/write permissions and accet default options
- edit nfs share -> nfs permissions -> create
- add ip subnet
- update squash map to elevate users to admins ( avoid for now, mount directory permissions mismatch when container is running as non root )
- check allow non privilaged ports
- check allow users to access subdirectories

k3s node requirements:
- `sudo apt install nfs-common`

configure nfs dynamic provisioner:
```
# add helm repository
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner

# install nfs provisioner
kubectl apply -f namespace.yaml
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --values values.yaml --namespace nfs-provisioner

# patch default storage class to not be the default
# kubectl  patch storageclass local-path -p '{"metadata": {"annotations": {"storageclass.kubernetes.io/is-default-class": "false"}}}'

```

