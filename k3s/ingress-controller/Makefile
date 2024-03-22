.PHONY: all build show_versions install

CHART_VERSION = 4.10.0

# Default target executed when no arguments are given to make.
all: build

######################
# PACKER
######################
build:
	helm template ingress-nginx \
		--repo https://kubernetes.github.io/ingress-nginx \
		--version $(CHART_VERSION) \
		--namespace ingress-nginx \
		--values values.yaml > manifests/nginx-ingress-$(CHART_VERSION).yaml

show_versions:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm search repo ingress-nginx --versions

install:
	kubectl apply -f manifests/namespace.yaml
	kubectl apply -f manifests/nginx-ingress-$(CHART_VERSION).yaml

######################
# HELP
######################

help:
	@echo '===================='
	@echo '-- DOCUMENTATION --'
	@echo 'build                        - build template for version'
	@echo 'show_versions                - list versions'
	@echo 'install                      - install nginx ingress controller
