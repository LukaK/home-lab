# services

## pihole

repository: https://mojo2600.github.io/pihole-kubernetes/
chart: pihole

```
# add repository
helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/

# install pihole chart
helm install pihole mojo2600/pihole --values pi-hole-values.yaml

```
