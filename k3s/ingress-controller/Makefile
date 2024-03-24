.PHONY: all build show_versions install clean

CHART_VERSION = 4.10.0
NAMESPACE = ingress-nginx

# Default target executed when no arguments are given to make.
all: build

build:
	helm template ingress-nginx \
		--repo https://kubernetes.github.io/ingress-nginx \
		--version $(CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values values.yaml > manifests/nginx-ingress-$(CHART_VERSION).yaml

show_versions:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm search repo ingress-nginx --versions

install:
	kubectl apply -f manifests/namespace.yaml
	kubectl apply -f manifests/nginx-ingress-$(CHART_VERSION).yaml

clean:
	kubectl delete -f manifests/nginx-ingress-$(CHART_VERSION).yaml
	kubectl delete -f manifests/namespace.yaml


######################
# HELP
######################

help:
	@echo '===================='
	@echo '-- DOCUMENTATION --'
	@echo 'build                        - build template for version'
	@echo 'show_versions                - list versions'
	@echo 'install                      - install nginx ingress controller'
	@echo 'clean                        - clean resources
