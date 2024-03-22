.PHONY: all template show_versions

CHART_VERSION = 4.10.0

# Default target executed when no arguments are given to make.
all: help

######################
# PACKER
######################
template:
	helm template ingress-nginx \
		--repo https://kubernetes.github.io/ingress-nginx \
		--version $(CHART_VERSION) \
		--namespace ingress-nginx \
		--values values.yaml > manifests/nginx-ingress-$(CHART_VERSION).yaml

show_versions:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm search repo ingress-nginx --versions


######################
# HELP
######################

help:
	@echo '===================='
	@echo '-- DOCUMENTATION --'
	@echo 'template                     - build template for version'
	@echo 'show_versions                - list versions'
