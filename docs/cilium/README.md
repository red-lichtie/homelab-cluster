# Cilium

[Cilium](https://cilium.io/) is an implementation of the [Container Network Interface (CNI)](https://www.cni.dev/).

## Installing the Gateway Operator and API

```shell
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v0.8.1/standard-install.yaml
```

Reference: [Installing a gateway controller](https://gateway-api.sigs.k8s.io/guides/#installing-a-gateway-controller) 

## Installing cilium

Reference: deploying [cilium on Talos](https://www.talos.dev/v1.5/kubernetes-guides/network/deploying-cilium/).

## Additional information

### Defining IP addresses for load balancers 

Make sure the address range you define in `kind: CiliumLoadBalancerIPPool` doesn't overlap with any other addresses in
your network.

A nice tool for this is [ipcalc](https://jodies.de/ipcalc), and it should be available as a package on your linux distro.

* [kubernetes/infrastructure/cilium/cilium/overlays/prod/resources/ciliumloadbalancerippool.yaml](../../kubernetes/infrastructure/cilium/cilium/overlays/prod/resources/ciliumloadbalancerippool.yaml)

### Complete OSI L2 announcements

Even though the OSI option for L2 announcements is enabled, cilium still needs to know how to inform the rest of the
network with a CRD `kind: CiliumL2AnnouncementPolicy`.

```yaml
externalIPs:
    enabled: true
l2announcements:
    enabled: true
```

* [kubernetes/infrastructure/cilium/cilium/overlays/prod/resources/ciliuml2announcementpolicy.yaml](../../kubernetes/infrastructure/cilium/cilium/overlays/prod/resources/ciliuml2announcementpolicy.yaml)

***
Installation files: [kubernetes/infrastructure/cilium](../../kubernetes/infrastructure/cilium)

