.PHONY: all build show_versions install clean

CHART_VERSION = 2.22.0
NAMESPACE = pihole

# Default target executed when no arguments are given to make.
all: build

build:

	helm template pihole pihole \
		--repo https://mojo2600.github.io/pihole-kubernetes/ \
		--version $(CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values values.yaml > manifests/pihole-$(CHART_VERSION).yaml

show_versions:
	helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/
	helm repo update
	helm search repo mojo2600 --versions

install:
	kubectl apply -f manifests/namespace.yaml
	kubectl apply -n $(NAMESPACE) -f manifests/pihole-$(CHART_VERSION).yaml

clean:
	kubectl delete -n $(NAMESPACE) -f manifests/pihole-$(CHART_VERSION).yaml
	kubectl delete -f manifests/namespace.yaml

######################
# HELP
######################

help:
	@echo '===================='
	@echo '-- DOCUMENTATION --'
	@echo 'build                        - build template for version'
	@echo 'show_versions                - list versions'
	@echo 'install                      - install pihole'
	@echo 'clean                        - clean resources'
