# Managing the cluster with Flux CD

I use [Flux](https://fluxcd.io/) to manage the software in my cluster.

Flux natively supports Mozilla SOPS, see the [Flux document](https://fluxcd.io/flux/guides/mozilla-sops/).

I use [Mozilla SOPS](https://github.com/mozilla/sops) to manage secrets, they are encrypted with
[age](https://github.com/FiloSottile/age) which means they can be pushed to public repositories.

## Bootstrapping Flux

Both the `user` and the `repository` have to be defined on your git server.

```bash
$  export GIT_USER=flux
$  export GIT_PASSWORD=verySecretPassword
$ flux bootstrap git \
 --username=$GIT_USER --password=$GIT_PASSWORD \
 --token-auth \
 --ca-file=/home/$USER/certs/SelfSigned-CA-Cert.crt \
 --url=https://git.home.themairs.net/flux/homenetwork.git \
 --branch=main \
 --path=kubernetes/clusters/prod
```
* You have to define the option `--ca-file=$CA_CERT` if you are using self-signed certificates.


```text
kubernetes/
├── clusters
│   └── prod
│       └── flux-system
```

### Install your server's sops secret

This should be the only time you'll need `kubectl` and that is to install a secret for flux, so that it knows how to
process your secrets.

```shell
sops --decrypt --encrypted-regex '^(data|stringData)$' kubernetes/sops/prod/flux-sops-agekey.prod.yaml | kubectl apply -f -
```

### update flux configuration to use the secret

I add the sops configuration directly to [kubernetes/clusters/prod/flux-system/gotk-sync.yaml](../kubernetes/clusters/prod/flux-system/gotk-sync.yaml):

```yaml
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: flux-system
  namespace: flux-system
spec:
  interval: 10m0s
  path: ./kubernetes/clusters/prod
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
  decryption:
    provider: sops
    secretRef:
      name: flux-sops-agekey
```

## Repository structure

`tree -a -I .git -I .gitignore --gitignore -d kubernetes`:
```text
kubernetes/
├── apps
│   ├── linkding
│   │   ├── apps
│   │   └── prod
│   │       └── database
│   ├── overlays
│   │   └── prod
│   └── podinfo
│       ├── apps
│       └── prod
├── clusters
│   └── prod
│       └── flux-system
├── infrastructure
│   ├── cert-manager
│   │   ├── app
│   │   │   ├── prod
│   │   │   └── release
│   │   └── overlays
│   │       └── prod
│   │           └── resources
│   ├── cilium
│   │   ├── cilium
│   │   │   ├── app
│   │   │   └── overlays
│   │   │       └── prod
│   │   │           └── resources
│   │   └── overlays
│   │       └── prod
│   ├── clusterdns
│   │   ├── bind9
│   │   │   ├── app
│   │   │   └── prod
│   │   ├── external-dns
│   │   │   ├── app
│   │   │   └── prod
│   │   └── overlays
│   │       └── prod
│   ├── csi-driver-nfs
│   │   ├── app
│   │   └── overlays
│   │       └── prod
│   │           └── storageclasses
│   ├── database-operators
│   │   ├── cloudnative-pg
│   │   ├── mariadb-operator
│   │   └── overlays
│   │       └── prod
│   ├── overlays
│   │   └── prod
│   └── rook-ceph
│       ├── overlays
│       │   └── prod
│       ├── rook-ceph
│       └── rook-ceph-cluster
│           ├── app
│           └── overlays
│               └── prod
│                   └── delete-rook
├── repositories
│   ├── git
│   ├── helm
│   ├── oci
│   └── s3
└── sops
    └── prod
```