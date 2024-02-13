# workstation-bootstrap

Resources for bootstraping arch workstation.

Configuration:
- uefi boot
- partitioning: 800M boot partition, the rest is encrypted btrfs root and home partitions
- systemd boot loader
- creates `ansible` user for system management
- configure localzone, hostname and locales
- install core packages and enable services ( fstrim, reflector, network manager, sshd, firewall )

Requirements:
- bash


### usage

```
# configuration options
vim group_vars/all.yaml

# start interactive base system installation
bash install-base-system.sh -d <disc>
```
