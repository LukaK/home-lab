.PHONY: all build show_versions install clean

CHART_VERSION = v1.14.4
NAMESPACE = cert-manager

# Default target executed when no arguments are given to make.
all: build

build:
	kubeseal -f ca-secret.yaml -w manifests/ca-sealedsecret.yaml
	helm template cert-manager \
		--repo https://charts.jetstack.io \
		--version $(CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values values.yaml > manifests/cert-manager-$(CHART_VERSION).yaml

show_versions:
	helm repo add jetstack https://charts.jetstack.io
	helm repo update
	helm search repo jetstack --versions

install:
	kubectl apply -f manifests/namespace.yaml
	kubectl apply -f manifests/cert-manager-$(CHART_VERSION).yaml
	kubectl wait --timeout=300s --for=condition=complete job -l app=startupapicheck -n $(NAMESPACE)
	kubectl apply -f manifests/ca-sealedsecret.yaml
	kubectl apply -f manifests/cluster-issuer.yaml

clean:
	kubectl delete -f manifests/cluster-issuer.yaml
	kubectl delete -f manifests/ca-sealedsecret.yaml
	kubectl delete -f manifests/cert-manager-$(CHART_VERSION).yaml
	kubectl delete -f manifests/namespace.yaml

######################
# HELP
######################

help:
	@echo '===================='
	@echo '-- DOCUMENTATION --'
	@echo 'build                        - build template for version'
	@echo 'show_versions                - list versions'
	@echo 'install                      - install certificate manager'
	@echo 'clean                        - clean resources
