# configurationo

Configuration scripts for home resources.

Playbooks:
- `bootstrap.yaml`: ensure ansible user is created and configured for management
- `pihole.yaml`: ensure pihole dns is configured
- `certificate_authority.yaml`: ensure ca server is configured and ssl certificates are created for home servers
- `proxmox_bootstrap.yaml`: ensure proxmox node has sudo package installed and proprietary package repositories are commented out
- `proxmox.yaml`: ensure proxmox node is configured
- `workstation.yaml`: ensure workstation is configured
- `workstation_dropbox.yaml`: ensure workstation links are created after dropbox sync

Roles:
- `bootstrap`: ensure ansible user for management is created and configured
- `core`: ensure hostname and locales are set up
- `docker`: ensure docker is installed and configured
- `firewall`: ensure firewall is installed and configured to pass only ssh
- `pihole`: ensure pihole is installed as docker instance, dns entries populated and ssl configured
- `proxmox`: ensure proxmox network interfaces are configured and ssl is enabled
- `sshd`: ensure ssh service is installed and hardened
- `update`: ensure systems are up to date
- `vm_guest`: ensure vm guest specific agents are installed
- `workstation`: ensure workstation is configured (drivers and packages are installed, root certificate installed, users and services configured)

Requirements:
- ansible

#### Usage
