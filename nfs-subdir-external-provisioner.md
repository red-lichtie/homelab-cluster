# nfs-subdir-external-provisioner

Source repository: [nfs-subdir-external-provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/)

## Directory structure
```text
self-hosted
└── kubernetes
    └── infrastructure
    │   └── namespaces
    │       └── nfs-provisioner
    │           └── nfs-subdir-external-provisioner
    │               ├── app
    │               └── prod
    └── repositories
        └── helm
```

### kubernetes/infrastructure/namespaces/nfs-provisioner/

#### namespace.yaml
```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: nfs-provisioner
  labels:
    kustomize.toolkit.fluxcd.io/prune: disabled
...
```

### kubernetes/infrastructure/namespaces/nfs-provisioner/nfs-subdir-external-provisioner/app/

#### helmrelease.yaml
```yaml
---
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: nfs-subdir-external-provisioner
  namespace: nfs-provisioner
spec:
  targetNamespace: nfs-provisioner
  releaseName: nfs-subdir-external-provisioner
  interval: 60m

  install:
    disableWait: true
  upgrade:
    disableWait: true

  chart:
    spec:
      chart: nfs-subdir-external-provisioner
      version: 4.0.18
      sourceRef:
        kind: HelmRepository
        name: nfs-subdir-external-provisioner
        namespace: flux-system
      interval: 60m
  valuesFrom:
    - kind: ConfigMap
      name: chart-values-overrides
...
```

#### kustomization.yaml

```yaml
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: nfs-provisioner
resources:
  - helmrelease.yaml
...
```

### kubernetes/infrastructure/namespaces/nfs-provisioner/nfs-subdir-external-provisioner/prod/

#### configmap.yaml

```yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: chart-values-overrides
  namespace: nfs-provisioner
data:
  values.yaml: |-
    nfs:
      server: nas-t.home-lab.net
      path: /KubernetesProd
      mountOptions:
        - nfsvers=4.1
      volumeName: nfs-subdir-external-provisioner-prod
      reclaimPolicy: Retain
    storageClass:
      name: nfs
...
```

#### kustomization.yaml

```yaml
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: nfs-provisioner
resources:
  - ./configmap.yaml
  - ../app
...
```

### kubernetes/repositories/helm/

#### nfs-subdir-external-provisioner.yaml

```yaml
---
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: HelmRepository
metadata:
  name: nfs-subdir-external-provisioner
  namespace: flux-system
spec:
  interval: 30m0s
  url: https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
...
```
