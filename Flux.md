# Managing the cluster with Flux CD

I use [Flux](https://fluxcd.io/) to manage the software in my cluster.

Flux natively supports Mozilla SOPS, see the [Flux document](https://fluxcd.io/flux/guides/mozilla-sops/).

I use [Mozilla SOPS](https://github.com/mozilla/sops) to manage secrets, they are encrypted with
[age](https://github.com/FiloSottile/age) which means they can be pushed to my git repositories.

## Repository structure
`tree -a -I .git -I .gitignore --gitignore -d self-hosted`:
```text
self-hosted
├── kubernetes
│   ├── apps
│   │   ├── namespaces
│   │   │   ├── default
│   │   │   │   ├── rabbitmq
│   │   │   │   └── test-nginx
│   │   │   └── test
│   │   │       └── test-nginx
│   │   └── overlays
│   │       └── prod
│   │           └── secrets
│   ├── clusters
│   │   └── prod
│   │   │   ├── flux-system
│   │   │   │   ├── gotk-components.yaml
│   │   │   │   ├── gotk-sync.yaml
│   │   │   │   └── kustomization.yaml
│   │   │   └── kustomization.yaml
│   ├── infrastructure
│   │   ├── namespaces
│   │   │   ├── cert-manager
│   │   │   │   └── cert-manager
│   │   │   │       ├── app
│   │   │   │       └── prod
│   │   │   │           ├── clusterissuers
│   │   │   │           └── secrets
│   │   │   ├── nfs-provisioner
│   │   │   │   └── nfs-subdir-external-provisioner
│   │   │   │       ├── app
│   │   │   │       └── prod
│   │   │   └── rabbitmq-cluster-operator
│   │   │       └── rabbitmq-cluster-operator
│   │   │           ├── app
│   │   │           └── prod
│   │   └── overlays
│   │       └── prod
│   │           └── secrets
│   ├── repositories
│   │   ├── git
│   │   ├── helm
│   │   ├── oci
│   │   └── s3
│   └── sops
│       ├── prod
│       │   ├── flux-sops-agekey.yaml
│       │   ├── kustomization.yaml
│       │   └── sops-secrets.yaml
│       └── README.md
└── .sops.yaml

```