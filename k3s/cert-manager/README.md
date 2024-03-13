# cert-manager with self-signed ssl certificates

How to setup cert manager:
- generate intermediate certificate and key
- create `nginx-ca-secret.yaml` from template file and add base64 encoded cert and key values
- deploy secret and `cluster-issuer.yaml` resources
- ensure that dns redirects cluster resources to nginx ingress ontroller ip


```
# download intermediate certificate from ca server

cp nginx-ca-secret.template.yaml nginx-ca-secret.yaml
# populate nginx-ca-secret.yaml

kubectl apply -f nginx-ca-secret.yaml
kubectl apply -f cluster-issuer.yaml

```
