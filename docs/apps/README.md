# Applications

## Update `default` namespace

Although the apps are in the same namespace as the default gateway, it is using a selector so the default namespace has
to be updated accordingly (e.g. label `shared-gateway-access: "true"`).

```yaml
apiVersion: v1                                                                                                                                                                                                                         
kind: Namespace                                                                                                                                                                                                                        
metadata:                                                                                                                                                                                                                              
  labels:                                                                                                                                                                                                                              
    kubernetes.io/metadata.name: default                                                                                                                                                                                               
    shared-gateway-access: "true"                                                                                                                                                                                                      
  name: default                                                                                                                                                                                                                        
```

## Installed applications


* [podinfo](podinfo.md)
* [linkding](linkding.md)