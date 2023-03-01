# Git Server

I chose [gitea](https://gitea.io/) for my server. It is lightweight and does exactly what I need it to do.

This is the first component to be installed because it is required to bootstrap the cluster.

## LXC and not a VM

LXC containers are natively supported by Proxmox and a VM is not needed for a native service like gitea.

**Don't forget to back up your git server!**