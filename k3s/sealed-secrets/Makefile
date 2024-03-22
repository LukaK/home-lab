.PHONY: all build show_versions install clean

CHART_VERSION = 2.15.2
NAMESPACE = kube-system

# Default target executed when no arguments are given to make.
all: build

build:
	helm template sealed-secrets \
		--repo https://bitnami-labs.github.io/sealed-secrets\
		--version $(CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--values values.yaml > manifests/sealed-secrets-$(CHART_VERSION).yaml

show_versions:
	helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
	helm repo update
	helm search repo sealed-secrets --versions

install:
	kubectl apply -f manifests/sealed-secrets-$(CHART_VERSION).yaml

clean:
	kubectl delete -f manifests/sealed-secrets-$(CHART_VERSION).yaml


######################
# HELP
######################

help:
	@echo '===================='
	@echo '-- DOCUMENTATION --'
	@echo 'build                        - build template for version'
	@echo 'show_versions                - list versions'
	@echo 'install                      - install sealed secrets'
	@echo 'clean                        - clean resources
