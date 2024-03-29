.PHONY: all build install clean build_prowlarr build_radarr build_sonarr build_transmission build_plex show_versions

PLEX_CHART_VERSION = 17.6.1
PROWLARR_CHART_VERSION = 16.6.0
RADARR_CHART_VERSION = 21.5.2
SONARR_CHART_VERSION = 21.5.3
TRANSMISSION_CHART_VERSION = 20.5.2
NAMESPACE = media

all: build

build_prowlarr:
	helm template prowlarr prowlarr \
		--repo https://charts.truecharts.org \
		--version $(PROWLARR_CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values prowlarr-values.yaml > manifests/04-prowlarr-$(PROWLARR_CHART_VERSION).yaml


build_sonarr:
	helm template sonarr sonarr \
		--repo https://charts.truecharts.org \
		--version $(SONARR_CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values sonarr-values.yaml > manifests/06-sonarr-$(SONARR_CHART_VERSION).yaml

build_radarr:
	helm template radarr radarr \
		--repo https://charts.truecharts.org \
		--version $(RADARR_CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values radarr-values.yaml > manifests/05-radarr-$(RADARR_CHART_VERSION).yaml

build_transmission:
	helm template transmission transmission \
		--repo https://charts.truecharts.org \
		--version $(TRANSMISSION_CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values transmission-values.yaml > manifests/07-transmission-$(TRANSMISSION_CHART_VERSION).yaml

build_plex:
	helm template plex plex \
		--repo https://charts.truecharts.org \
		--version $(PLEX_CHART_VERSION) \
		--namespace $(NAMESPACE) \
		--include-crds \
		--values plex-values.yaml > manifests/08-plex-$(PLEX_CHART_VERSION).yaml

show_versions:
	helm repo add pree-helm-charts https://charts.pree.dev
	helm repo update
	helm search repo truecharts --versions | grep -e prowlarr -e radarr -e sonarr -e transmission -e plex

build: build_prowlarr build_radarr build_sonarr build_transmission build_plex

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
	@echo 'show_versions                - show chart versions'
