# Ubuntu Server Focal
# ---
# Packer Template to create an Ubuntu Server (Focal) on Proxmox

packer {
  required_plugins {
    proxmox-iso = {
       version = ">= 1.1.7"
      source = "github.com/hashicorp/proxmox"
    }
  }
}


# Variable Definitions
variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

locals {
    configuration = [
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
}

# Resource Definiation for the VM Template
source "proxmox-iso" "ubuntu-server-focal" {

    # proxmox connection settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    insecure_skip_tls_verify = false

    # vm fixed general settings
    vm_name = "ubuntu-server-focal"
    template_description = "Ubuntu Server Focal Image"

    # iso file configuration
    iso_file = "local:iso/ubuntu-20.04.3-live-server-amd64.iso"
    iso_storage_pool = "local"
    unmount_iso = true

    # vm system settings
    qemu_agent = true

    # hard disc settings
    scsi_controller = "virtio-scsi-pci"

    # qcow2 issues: https://github.com/hashicorp/packer-plugin-proxmox/issues/92
    disks {
        disk_size = "20G"
        # format = "qcow2"
        format = "raw"
        storage_pool = "local-lvm"
        type = "virtio"
    }

    # cpu settings
    cores = "1"

    # ram settings
    memory = "2048"

    # network settings
    network_adapters {
        model = "virtio"
        bridge = "vmbr0"
        firewall = "false"
        vlan_tag = "10"
    }

    # cloud init settings
    cloud_init = true
    cloud_init_storage_pool = "local-lvm"

    # packer boot commands
    boot_command = [
        "<esc><wait><esc><wait>",
        "<f6><wait><esc><wait>",
        "<bs><bs><bs><bs><bs>",
        "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
        "--- <enter>"
    ]
    boot = "c"
    boot_wait = "5s"

    # packer auto install settings
    http_directory = "http"
    http_bind_address = "0.0.0.0"
    http_port_min = 8800
    http_port_max = 9000

    ssh_username = "ansible"
    ssh_private_key_file = "~/.ssh/ansible/id_rsa"

    # timeout settings
    ssh_timeout = "40m"
}

build {

    name = "ubuntu-server-focal"

    # add source for every proxmox node
    dynamic "source" {
        for_each = local.configuration
        labels = ["proxmox-iso.ubuntu-server-focal"]

        content {
            node = source.value.node_name
            vm_id = source.value.vm_id
        }
    }

    # provision vm template for cloud init integration in proxmox #1
    provisioner "shell" {
        inline = [
            "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
            "sudo rm /etc/ssh/ssh_host_*",
            "sudo truncate -s 0 /etc/machine-id",
            "sudo apt -y autoremove --purge",
            "sudo apt -y clean",
            "sudo apt -y autoclean",
            "sudo cloud-init clean",
            "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
            "sudo sync"
        ]
    }

    # provision vm template for cloud init integration in proxmox #2
    provisioner "file" {
        source = "files/99-pve.cfg"
        destination = "/tmp/99-pve.cfg"
    }

    # provision vm template for cloud init integration in proxmox #3
    provisioner "shell" {
        inline = [ "sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg" ]
    }
}
