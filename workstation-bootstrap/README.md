# workstation-bootstrap

Resources for bootstraping arch workstation.

Configuration:
- uefi boot
- partitioning: 800M boot partition, the rest is encrypted btrfs root and home partitions
- systemd boot loader
- system configuration in `group_vars/all.yaml`
- creates `ansible` user for system management
- ... ( todo: add specifics for system configuration )

Requirements:
- ansible
- bash


### usage

```
bash install-system.sh -d <disc>
```
