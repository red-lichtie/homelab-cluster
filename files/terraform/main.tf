#
variable "virtualmachines" {
  type = map(object({
    vmid = number
    instance_label = string
    instance_hostname = string
    ipconfig0 = string
    instance_drive_size = string
    instance_memory_kb = number
    target_node = string
  }))
}

resource "proxmox_vm_qemu" "k8snode" {

  for_each = var.virtualmachines

  vmid      = each.value.vmid

  clone     = "ubuntu-22.10-cloudimg"
  os_type   = "cloud-init"

  name        = each.value.instance_hostname
  desc        = each.value.instance_label
  target_node = each.value.target_node

  qemu_os    = "l26"
  full_clone = true

  scsihw      = "virtio-scsi-pci"
  boot        = "order=scsi0"

  cpu     = "kvm64"
  cores   = 2
  sockets = 1
  vcpus   = 2
  balloon = 512
  memory  = each.value.instance_memory_kb

  disk {
    type = "scsi"
    size = each.value.instance_drive_size
    storage = "cephblockdevice"
  }

  vga {
    type = "serial0"
  }

  ipconfig0 = each.value.ipconfig0
  nameserver = "192.168.122.1"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
  }

  ciuser = "kubeadm"
  cipassword = "password"
  sshkeys = <<EOF
    ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBKR4eZKowtwGtkia6IFgasCybSf0VAvFR0IdYySePbTjY+4xUf0mpL43Q9Cwt2TXRRAER930BAho85z59eCplLE= bill.mair@pc
  EOF

}
