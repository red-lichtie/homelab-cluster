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


# Cilium

```shell
helm repo add cilium https://helm.cilium.io/
helm repo update
```

```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v0.5.1/config/crd/standard/gateway.networking.k8s.io_gatewayclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v0.5.1/config/crd/standard/gateway.networking.k8s.io_gateways.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v0.5.1/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v0.5.1/config/crd/experimental/gateway.networking.k8s.io_referencegrants.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v0.7.0/config/crd/experimental/gateway.networking.k8s.io_tlsroutes.yaml
```
```shell
helm install \
    cilium \
    cilium/cilium \
    --version 1.14.3 \
    --namespace kube-system \
    --set gatewayAPI.enabled=true \
    --set l2announcements.enabled=true \
    --set ipam.mode=kubernetes \
    --set=kubeProxyReplacement=true \
    --set=securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,PERFMON,BPF,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --set=securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE,NET_ADMIN,SYS_ADMIN,SYS_RESOURCE,PERFMON,BPF}" \
    --set=cgroup.autoMount.enabled=false \
    --set=cgroup.hostRoot=/sys/fs/cgroup \
    --set=k8sServiceHost=localhost \
    --set=k8sServicePort=7445
```


# Patches

## Enable certificate rotation

File name: Patch-EnableCertRotate.yaml
```yaml
talosctl patch --patch-file=Patch-EnableCertRotate.yaml mc --nodes talos-c1,talos-c2,talos-c3,talos-a1,talos-a2,talos-a3
```


## Enable external virtual IP for API Server

See [Virtual (shared) IP](https://www.talos.dev/v1.5/talos-guides/network/vip/)

**WARNING: You probably can't use the suggested _eth0_ device due to predictable network adapter naming!**

Check the `dmesg` output to get the new name of the device:
```shell
talosctl --nodes talos-c1 dmesg | grep eth0
talos-c1: kern:    info: [2023-10-15T15:13:52.298831252Z]: virtio_net virtio2 enx0a69396de0c9: renamed from eth0
```
In my case `eth0` was renamed to `enx0a69396de0c9`.

File name: `Patch-VIP-talos-c1.yaml`
```yaml
machine:
  network:
    interfaces:
      - interface: enx0a69396de0c9
        dhcp: true
        vip:
          ip: 192.168.76.230
```

Patch the control nodes
```sh
talosctl patch mc -n talos-c1 --patch-file Patch-VIP-talos-c1.yaml
```

Rinse and repeat for each of your control plane nodes.

## Enable internal virtual IP for API Server

See [KubePrism](https://www.talos.dev/v1.5/kubernetes-guides/configuration/kubeprism/)

File name: `Patch-KubePrism.yaml`
```yaml
machine:
  features:
    kubePrism:
      enabled: true
      port: 7445
```

Patch all nodes
```sh
talosctl patch mc -n talos-c1,talos-c2,talos-c3,talos-a1,talos-a2,talos-a3 --patch-file Patch-KubePrism.yaml
```