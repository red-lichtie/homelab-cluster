# Basic configuration

## Create the age secret key for production


```yaml
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: flux-system
  namespace: flux-system
spec:
  interval: 10m0s
  path: ./
  prune: true
  sourceRef:
    kind: GitRepository
    name: ${yourRepositoryName}
  decryption:
    provider: sops
    secretRef:
      name: sops-age
...
```
