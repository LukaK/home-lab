# TODO: add disc resizing
# TODO: add worker nodes
# TODO: add network configuration in cloud init
# TODO: connect with ansible and configure working cluster from nothing
resource "proxmox_vm_qemu" "k8-ctrl" {
    count = 3

    name = "k8-ctrl-${count.index + 1}"
    desc = "Kubernetes controll node"
    agent = 1
    target_node = "proxmox${count.index + 1}"
    tags = "k8-control"

    vmid = tonumber("1${count.index + 1}05")
    clone = "ubuntu-server-focal"
    full_clone = true

    cores = 3
    sockets = 1
    cpu = "host"
    memory = 4000

    # network {
    #     bridge = "vmbr1"
    #     model  = "virtio"
    #     tag    = 10
    # }

    # TODO: Should this match image definition
    # scsihw = "virtio-scsi-pci"  # default virtio-scsi-pci
    # disk {
    #     storage = "local-lvm"
    #     type = "virtio"
    #     size = "40G"
    #     iothread = 1
    # }

    # -- lifecycle
    # lifecycle {
    #    ignore_changes = [
    #        disk,
    #        vm_state
    #    ]
    #}

    # TODO: Select subset of cloud-init options that you need
    # Cloud Init Settings
    # ipconfig0 = "ip=10.20.0.2/16,gw=10.20.0.1"
    # nameserver = "10.0.10.94"
    # ciuser = "xcad"
    # sshkeys = var.PUBLIC_SSH_KEY
}
