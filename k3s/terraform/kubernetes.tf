# TODO: add disc resizing
resource "proxmox_vm_qemu" "k3s-ctrl" {
    count = 3

    name = "k3s-control-${count.index + 1}"
    desc = "k3s controll node"
    agent = 1
    target_node = "proxmox${count.index + 1}"
    tags = "k3s;k3s-control"

    vmid = tonumber("1${count.index + 1}05")
    clone = "ubuntu-server-focal"
    full_clone = true
    onboot = true

    cores = 1
    sockets = 1
    cpu = "host"
    memory = 4000

    network {
        bridge = "vmbr0"
        model  = "virtio"
        tag    = 10
    }

    # -- lifecycle
    lifecycle {
        ignore_changes = [
            disk,
            vm_state
        ]
    }

    # cloud init settings
    ipconfig0 = "ip=10.0.10.${84 + count.index}/24,gw=10.0.10.1"
    nameserver = "10.0.10.94"
}


resource "proxmox_vm_qemu" "k3s-wrk" {
    count = 3

    name = "k3s-worker-${count.index + 1}"
    desc = "k3s worker node"
    agent = 1
    target_node = "proxmox${count.index + 1}"
    tags = "k3s;k3s-worker"

    vmid = tonumber("1${count.index + 1}06")
    clone = "ubuntu-server-focal"
    full_clone = true
    onboot = true

    cores = 13
    sockets = 1
    cpu = "host"
    memory = 25000

    network {
        bridge = "vmbr0"
        model  = "virtio"
        tag    = 10
    }

    # NOTE: issues with disc resizing
    # scsihw = "virtio-scsi-pci"  # default virtio-scsi-pci
    # disk {
    #     storage = "local-lvm"
    #     type = "virtio"
    #     size = "20G"
    #     iothread = 1
    # }

    # -- lifecycle
    lifecycle {
        ignore_changes = [
            disk,
            vm_state
        ]
    }

    # cloud init settings
    ipconfig0 = "ip=10.0.10.${87 + count.index}/24,gw=10.0.10.1"
    nameserver = "10.0.10.94"
}
