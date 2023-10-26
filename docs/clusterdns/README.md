# Cluster DNS



## bind9



## external-dns

Make sure you enable the gateway API sources:

```yaml
sources:
  - gateway-httproute
  - gateway-tlsroute
```

***
Installation files: [kubernetes/infrastructure/clusterdns](../../kubernetes/infrastructure/clusterdns)
