.PHONY: all build install clean

NAMESPACE = monitoring

all: build

build:
	kubeseal -f services-secret.yaml -w manifests/04-services-sealedsecret.yaml
	@echo 'Nothing to build'

install:
	kubectl apply -f manifests -n $(NAMESPACE)

clean:
	kubectl delete -f manifests -n $(NAMESPACE)

######################
# HELP
######################

help:
	@echo '===================='
	@echo '-- DOCUMENTATION --'
	@echo 'build                        - build templates'
	@echo 'install                      - install'
	@echo 'clean                        - clean resources'
