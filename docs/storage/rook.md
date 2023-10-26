# Rook

How to use Proxmox's passed through drives as the backing store for [Rook](https://rook.io/).

Deploying Rook on [Talos](https://www.talos.dev/v1.5/kubernetes-guides/configuration/ceph-with-rook/)

Installation files: [kubernetes/infrastructure/rook-ceph](../../kubernetes/infrastructure/rook-ceph)

# The files

## [ConfigMap](../../kubernetes/infrastructure/rook-ceph/rook-ceph-cluster/overlays/prod/configmap.yaml)

The passed through drives on each of the cluster nodes have been individually named, this isn't really required as the
default will use all unused and emtpy/unformatted drives.
```yaml
storage:
    useAllDevices: true
    useAllNodes: true
```

The dashboard is encrypted using a Gateway API [HTTPRoute](../../kubernetes/infrastructure/rook-ceph/rook-ceph-cluster/overlays/prod/httproute.yaml)
```yaml
dashboard:
    ssl: false
```

As it isn't a dedicated high performance storage cluster the requested memory and CPU are massively reduced from the
default values.

## [Ceph tools](../../kubernetes/infrastructure/rook-ceph/rook-ceph-cluster/overlays/prod/ceph-tools-deployment.yaml)

Used to access the ceph CLI and directly access the cluster.

```shell
$ kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash
```