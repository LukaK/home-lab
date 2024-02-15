# configurationo

Configuration scripts for home resources.

Requirements:
- ansible

Playbooks:
- `pihole.yaml`: ensure pihole dns is configured
- `certificate_authority.yaml`: ensure ca server is configured and ssl certificates are created for home servers
- `proxmox_bootstrap.yaml`: ensure proxmox node has sudo package installed and proprietary package repositories are commented out
- `proxmox.yaml`: ensure proxmox node is configured
- `workstation.yaml`: ensure workstation is configured
- `workstation_dropbox.yaml`: ensure workstation links are created after dropbox sync

Roles:
- `core`: base system settings and creating ansible user for management
- `docker`: ensure docker is installed and configured
- `firewall`: ensure firewall is installed and configured to pass only ssh
- `pihole`: ensure pihole is installed as docker instance, dns entries populated and ssl configured
- `proxmox`: ensure proxmox network interfaces are configured and ssl is enabled
- `sshd`: ensure ssh service is installed and hardened
- `update`: ensure systems are up to date
- `vm_guest`: ensure vm guest specific agents are installed
- `workstation`: ensure workstation is configured (drivers and packages are installed, root certificate installed, users and services configured)


#### Inventory file example
```
all:
  vars:
    i_ansible_public_key_path: ""
    i_timezone: ""
    i_locale_list: ["", ""]

ungrouped:
  hosts:
    ca.lab:
      ansible_host: ""
      i_root_ca_pass: "{{ vault_ca_root_ca_pass }}"
      i_ssl_configuration:
        - { subject_alt_name: "DNS:ca.lab", hostname: 'ca.lab' }
        - { subject_alt_name: "DNS:pihole.lab", hostname: 'pihole.lab' }
        - { subject_alt_name: "DNS:proxmox1.lab", hostname: 'proxmox1.lab' }
        - { subject_alt_name: "DNS:proxmox2.lab", hostname: 'proxmox2.lab' }
        - { subject_alt_name: "DNS:proxmox3.lab", hostname: 'proxmox3.lab' }
        - { subject_alt_name: "DNS:nas.lab", hostname: 'nas.lab' }

    pihole.lab:
      ansible_host: ""
      i_docker_image: "pihole/pihole:latest"
      i_admin_password: "{{ vault_pihole_password }}"
      i_ssl_key : "{{ vault_pihole_ssl_key }}"
      i_ssl_cert: "{{ vault_pihole_ssl_cert }}"

    unifi_controller:
      ansible_host: ""

proxmox_servers:
  hosts:
    proxmox1.lab:
      ansible_host: ""
      i_ssl_key : "{{ vault_proxmox1_ssl_key }}"
      i_ssl_cert: "{{ vault_proxmox1_ssl_cert }}"

    proxmox2.lab:
      ansible_host: ""
      i_ssl_key: "{{ vault_proxmox2_ssl_key }}"
      i_ssl_cert: "{{ vault_proxmox2_ssl_cert }}"

    proxmox3.lab:
      ansible_host: ""
      i_ssl_key: "{{ vault_proxmox3_ssl_key }}"
      i_ssl_cert: "{{ vault_proxmox3_ssl_cert }}"
  vars:
    i_default_gateway: ""
    i_network_mask: "/24"
    i_bootstrap_user: "{{ vault_proxmox_servers_bootstrap_user }}"
    i_bootstrap_pass: "{{ vault_proxmox_servers_bootstrap_pass }}"

workstations:
  hosts:
    workstation1.lab:
      ansible_host: ""
      i_install_nvidia_driver: true

    workstation2.lab:
      ansible_host: ""
      i_install_nvidia_driver: false

    workstation3.lab:
      ansible_host: ""
      i_install_nvidia_driver: false

    workstation4.lab:
      ansible_host: ""
      i_install_nvidia_driver: true
  vars:
    i_root_pass: "{{ vault_workstation_root_pass }}"
    i_user_configs: "{{ vault_workstation_user_configs }}"
    i_root_ca_cert: "{{ vault_workstation_root_ca_cert }}"
```


#### Usage

```
# install requirements
ansible-galaxy install -r roles/requirements.yaml

ansible-playbook --ask-vault-pass playbooks/pihole.yaml
```
