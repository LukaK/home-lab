.PHONY: all build install clean

NAMESPACE = media

all: build

build:
	kubeseal -f services-secret.yaml -w manifests/04-services-sealedsecret.yaml

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
	@echo 'build                        - build template for version'
	@echo 'install                      - install pihole'
	@echo 'clean                        - clean resources'
