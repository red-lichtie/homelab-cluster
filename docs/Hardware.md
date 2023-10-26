# Hardware

I use 3 * old [HP EliteDesk 800 G3 SFF](https://support.hp.com/us-en/document/c05369814) PCs for my cluster (refurbished).

I went with x64 instead of ARM (e.g. Raspberry PI 4) for my production servers because there are still so many projects
that only deliver for the AMD64 (X86_64) platform. The ability to expand and add hardware was another major reason for
not using ARM.

## Cluster servers

The HP EliteDesk 800 G3 SFF supports [Intel vPro](https://www.intel.com/content/www/us/en/architecture-and-technology/vpro/what-is-vpro.html),
a poor man's alternative to having a full server board with IPMI.

### Additional storage

I upgraded the hardware for server use.

* RAM -> 48 GiB DDR4 (2 * 8 GiB + 2 * 16 GiB)
* Storage
    * 256 GB SSD Operating System
    * 500 GB NMVe (Ceph Storage)
    * 500 GB SSD (Ceph Storage)

### Optional additional networking adapter

The 1 GiB ethernet adapter is sufficient for normal usage, but I felt that it wasn't going to
be sufficient for synchronizing the storage.

So each of the nodes also has an additional 2.5 GiB/S ethernet adapter, sharing a *dumb* 2.5 GiB/S Switch.
