# cert-manager with self-signed ssl certificates

How to setup cert manager:
- generate intermediate certificate and key
- create `nginx-ca-secret.yaml` from template file and add base64 encoded cert and key values
- deploy secret and `cluster-issuer.yaml` resources
- ensure that dns redirects cluster resources to nginx ingress ontroller ip


```
# create namespace
kubectl create namespace cert-manager

# install cert manager
helm repo add jetstack https://charts.jetstack.io --force-update
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.14.4 \
  --set installCRDs=true

# download intermediate certificate from ca server
cp nginx-ca-secret.template.yaml nginx-ca-secret.yaml
# populate nginx-ca-secret.yaml

kubectl apply -f nginx-ca-secret.yaml
kubectl apply -f cluster-issuer.yaml

```
