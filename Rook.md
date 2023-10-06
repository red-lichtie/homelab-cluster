# Cluster storage

How to use Proxmox's Ceph storage as the backing store for with [Rook](https://rook.io/).

I followed these documents for installing Rook so that it uses Promox's ceph installation:

* [External Storage Cluster - Rook Ceph Documentation](https://rook.io/docs/rook/v1.12/CRDs/Cluster/external-cluster)
* [SES 7 | Deploying and Administering SUSE Enterprise Storage with Rook](https://documentation.suse.com/ses/7/single-html/ses-rook/index.html#rook-external-cluster)
* [Configuring Rook with External Ceph | by Alex Punnen | Techlogs | Medium](https://medium.com/techlogs/configuring-rook-with-external-ceph-6b4b49626112)

I enabled the S3 server in ceph using this guide:

* [User:Grin/Ceph Object Gateway - Proxmox VE](https://pve.proxmox.com/wiki/User:Grin/Ceph_Object_Gateway)
