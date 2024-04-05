.PHONY: all build install clean

all: build

build:
	pushd overlays/synology-csi && \
		kubectl create secret -n synology-csi generic client-info-secret --from-file=client-info.yml --dry-run=client -o yaml > client-info-secret.yaml && \
		kubeseal -f client-info-secret.yaml -w client-info-sealedsecret.yaml && \
		popd

install:
	kubectl apply -k overlays/synology-csi

clean:
	kubectl delete -k overlays/synology-csi


######################
# HELP
######################

help:
	@echo '===================='
	@echo '-- DOCUMENTATION --'
	@echo 'build                        - build resources for synology-csi'
	@echo 'install                      - install synology-csi'
	@echo 'clean                        - clean resources'
