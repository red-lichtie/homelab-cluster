# Networking and Ingress configuration

I wanted all ingresses to be automatically registered in DNS.
Created ingress instances are monitored by `external-dns` and applied to an instance of  `coredns` that can be queried
by the network's main infrastructure.

## Components 

### [Traefik](https://doc.traefik.io/traefik/) The main ingress controller
![image](https://t1.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://doc.traefik.io&size=64)

Traefik is installed automatically as part of Tim's k3s ansible playbook.

### [CoreDNS](https://github.com/coredns/coredns) DNS server for ingress instances
![image](https://t1.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://coredns.io&size=64)

CoreDNS installation and configuration is a part of the `external-dns` tutorial

### [external-dns](https://github.com/kubernetes-sigs/external-dns) Bridge between kubernetes and the DNS server
## <img src="https://github.com/kubernetes-sigs/external-dns/blob/master/docs/img/external-dns.png?raw=true" alt="image" height="64"/>external-dns

I based my installation on the [external-dns tutorial for CoreDNS](https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/coredns.md)

---
* _external-dns also supports other DNS servers, e.g. [Pi-Hole](https://pi-hole.net/)_