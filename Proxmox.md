# Proxmox Virtualization Environment

I choose [Proxmox Virtualization Environment](https://www.proxmox.com/en/proxmox-ve) because it is an easy to
use virtualization platform that comes with an integrated high availability storage system [Ceph](https://ceph.com/).

## Getting Proxmox and installing Proxmox

You can download Proxmox at it's download site [here](https://www.proxmox.com/en/downloads/category/proxmox-virtual-environment).

I use [Ventoy](https://ventoy.net/) to keep all my bootable images on a single stick.

See:
* [Get started](https://www.proxmox.com/en/proxmox-ve/get-started)
* [Cluster Manager](https://pve.proxmox.com/pve-docs/chapter-pvecm.html)
* [Deploy Hyper-Converged Ceph Cluster](https://pve.proxmox.com/pve-docs/chapter-pveceph.html)
  * Optional: Define 2.5GB/S Adapter for ceph synchronization

[Documentation](https://pve.proxmox.com/pve-docs/)

## Network - configure single adapter for VLAN support

Setting up VLAN ID etc.

## Ceph - enable S3 support

Configure the storage

# [Metal As A Service](https://maas.io/)

I want to investigate this for the initial configuration. Maybe I can provision Proxmox in a headless installation.