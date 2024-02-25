resource "proxmox_vm_qemu" "srv-prod-1" {
    name = "test-server-1"
    desc = "test server"
    # agent = 1
    target_node = "proxmox2"
    tags = "k8-control"

    # define_connection_info = false

    # -- only important for full clone
    vmid = 20002
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

    # scsihw = "virtio-scsi-pci"  # default virtio-scsi-pci

    # disk {
    #     storage = "pv1"
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

    # Cloud Init Settings
    # ipconfig0 = "ip=10.20.0.2/16,gw=10.20.0.1"
    # nameserver = "10.20.0.1"
    # ciuser = "xcad"
    # sshkeys = var.PUBLIC_SSH_KEY
}
