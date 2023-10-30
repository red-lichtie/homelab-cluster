# Talos Linux

Proxmox VE virtual machines (VMs) running [Talos Linux](https://www.talos.dev/).

[Proxmox](https://www.talos.dev/v1.5/talos-guides/install/virtualized-platforms/proxmox/)


## talosctl

To get the Talos command line interface (CLI) see the [quick start](https://www.talos.dev/v1.5/introduction/quickstart/)
page on the Talos site.

### Enable auto completion

```shell
source<(talosctl completion bash)
```

## Generate the configuration files

```shell
export CONTROL_PLANE_IP=192.168.76.230
talosctl gen config talos-proxmox-cluster https://$CONTROL_PLANE_IP:6443 \
  --config-patch-control-plane @config-patch-control-plane.yaml \
  --config-patch @config-patch.yaml
```

### Set the configuration for talosctl

```shell
export TALOSCONFIG=$PWD/talosconfig
```

## Configure control plane
```shell
talosctl apply-config --insecure --nodes talos-c1 --file controlplane.yaml
talosctl apply-config --insecure --nodes talos-c2 --file controlplane.yaml
talosctl apply-config --insecure --nodes talos-c3 --file controlplane.yaml
```

## Configure agents/workers
```shell
talosctl apply-config --insecure --nodes talos-a1 --file worker.yaml
talosctl apply-config --insecure --nodes talos-a2 --file worker.yaml
talosctl apply-config --insecure --nodes talos-a3 --file worker.yaml
```

## Bootstrap the cluster
Pick one of your control plane nodes and use it to bootstrap the cluster.
```shell
talosctl config node 192.168.77.101
talosctl config endpoint 192.168.77.101
talosctl bootstrap
```


## Get the kubernetes configuration
Obe the cluster is up and running, you can get the configuration for kubectl.

```shell
talosctl kubeconfig .
export KUBECONFIG=$PWD/kubeconfig
```
