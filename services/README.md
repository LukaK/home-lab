# services

TODO:
- move nfs dynamic provisioner in k3s configuration


## pihole

repository: https://mojo2600.github.io/pihole-kubernetes/
chart: pihole

```
# install namespace

# add repository
helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/

# install pihole chart
helm install pihole mojo2600/pihole --values pihole-values.yaml --namespace pihole

```
