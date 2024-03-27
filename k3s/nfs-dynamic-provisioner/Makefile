
.PHONY: all build show_versions install clean

CHART_VERSION = 4.0.18
NAMESPACE = nfs-provisioner

# Default target executed when no arguments are given to make.
all: build

build:
	helm template  nfs-subdir-external-provisioner \
		--repo https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner\
		--version $(CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values values.yaml > manifests/nfs-external-provisioner-$(CHART_VERSION).yaml

show_versions:
	helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner
	helm repo update
	helm search repo nfs-subdir-external-provisioner --versions

install:
	kubectl apply -f manifests/namespace.yaml
	kubectl apply -n $(NAMESPACE) -f manifests/nfs-external-provisioner-$(CHART_VERSION).yaml
	kubectl wait pods --timeout=300s --for=condition=Ready -l app=nfs-subdir-external-provisioner -n $(NAMESPACE)

clean:
	kubectl delete -n $(NAMESPACE) -f manifests/nfs-external-provisioner-$(CHART_VERSION).yaml
	kubectl delete -f manifests/namespace.yaml


######################
# HELP
######################

help:
	@echo '===================='
	@echo '-- DOCUMENTATION --'
	@echo 'build                        - build template for version'
	@echo 'show_versions                - list versions'
	@echo 'install                      - install nfs external privisioner'
	@echo 'clean                        - clean resources
