.PHONY: all build install clean build_prowlarr show_versions build_radarr show_radarr_values build_sonarr show_sonarr_values

PROWLARR_CHART_VERSION = 1.32.0
RADARR_CHART_VERSION = 0.1.0
SONARR_CHART_VERSION = 0.1.0
TRANSMISSION_CHART_VERSION = 0.1.0
NAMESPACE = media

all: build

build_prowlarr:
	helm template prowlarr prowlarr \
		--repo https://charts.pree.dev \
		--version $(PROWLARR_CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values prowlarr-values.yaml > manifests/04-prowlarr-$(PROWLARR_CHART_VERSION).yaml

show_versions:
	helm repo add pree-helm-charts https://charts.pree.dev
	helm repo update
	helm search repo pree-helm-charts --versions

build_radarr:
	helm template radarr radarr \
		--repo https://bananaspliff.github.io/geek-charts \
		--version $(RADARR_CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values radarr-values.yaml > manifests/05-radarr-$(RADARR_CHART_VERSION).yaml

show_radarr_values:
	helm repo add bananaspliff https://bananaspliff.github.io/geek-charts
	helm repo update
	helm search repo bananaspliff --versions

build_sonarr:
	helm template sonarr sonarr \
		--repo https://bananaspliff.github.io/geek-charts \
		--version $(SONARR_CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values sonarr-values.yaml > manifests/06-sonarr-$(SONARR_CHART_VERSION).yaml

show_sonarr_values:
	helm repo add bananaspliff https://bananaspliff.github.io/geek-charts
	helm repo update
	helm search repo bananaspliff --versions


# build_transmission:
# 	helm template transmission-openvpn transmission-openvpn \
# 		--repo https://bananaspliff.github.io/geek-charts \
# 		--version $(TRANSMISSION_CHART_VERSION) \
# 		--namespace $(NAMESPACE) \
# 		--include-crds \
# 		--values transmission-openvpn-values.yaml > manifests/06-transmission-openvpn-$(TRANSMISSION_CHART_VERSION).yaml
#
# show_transmission_values:
# 	helm repo add bananaspliff https://bananaspliff.github.io/geek-charts
# 	helm repo update
# 	helm search repo bananaspliff --versions

build: build_prowlarr build_radarr build_sonarr

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
