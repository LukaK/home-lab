# iso file configuration
iso_file = "local:iso/ubuntu-20.04.3-live-server-amd64.iso"
iso_storage_pool = "local"


# resources
disc_size = "20G"
cpu = "1"
memory = "1024"

# ntwork configuration
network_model = "virtio"
network_bridge = "vmbr0"
network_vlan_tag = "10"

# connection configuration
ssh_username = "ansible"
ssh_private_key_file = "~/.ssh/ansible/id_rsa"

# vm id node pairs
vm_configuration = [
    {
        node_name = "proxmox1"
        vm_id = "2101"
    },
    {
        node_name = "proxmox2"
        vm_id = "2201"
    },
    {
        node_name = "proxmox3"
        vm_id = "2301"
    }
]
