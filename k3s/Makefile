.PHONY: install clean

# Default target executed when no arguments are given to make.
install:
	cd sealed-secrets && make && make install
	cd nfs-dynamic-provisioner && make && make install
	cd synology-csi && make && make install
	cd cert-manager && make && make install
	cd ingress-controller && make && make install

clean:
	cd ingress-controller && make clean
	cd cert-manager && make clean
	cd nfs-dynamic-provisioner && make clean
	cd synology-csi && make clean
	cd sealed-secrets && make clean


######################
# HELP
######################

help:
	@echo '===================='
	@echo '-- DOCUMENTATION --'
	@echo 'install                      - install resources'
	@echo 'clean                        - clean resources'
