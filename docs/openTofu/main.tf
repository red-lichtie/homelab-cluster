# Define the structure of records in virtualmachines.auto.tfvars

variable "virtualmachines" {
  type = map(object({
    vmid = number
    instance_label = string
    instance_name = string
    instance_drive_size = string
    instance_memory_kb = number
    target_node = string
    macaddr = string
  }))
}

resource "proxmox_vm_qemu" "talos-node" {

  lifecycle {
    create_before_destroy = false
    prevent_destroy = true
    ignore_changes = []
  }

  for_each = var.virtualmachines

  # General
  vmid        = each.value.vmid
  name        = each.value.instance_name
  desc        = each.value.instance_label
  target_node = each.value.target_node

  # Booting
  oncreate = false
  onboot = true

  # Talos changes
  define_connection_info = false
  hotplug = ""

  # OS
  iso = "cephfs:iso/talos-v1.5.4-amd64.iso"
  qemu_os    = "l26"

  # System
  bios       = "SeaBIOS"
  scsihw     = "virtio-scsi-pci"

  # Disks
  disk {
    type = "scsi"
    size = each.value.instance_drive_size
    storage = "osd"
    ssd = 1
  }

  # CPU
  sockets = 1
  cores   = 4
  vcpus   = 4
  cpu     = "x86-64-v2-AES"

  # Memory
  memory  = each.value.instance_memory_kb
  balloon = 512

  # Network
  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = 3
    macaddr = each.value.macaddr
  }
}
