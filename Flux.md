# Managing the cluster with Flux CD

I use [Flux](https://fluxcd.io/) to manage the software in my cluster.

Flux natively supports Mozilla SOPS, see the [Flux document](https://fluxcd.io/flux/guides/mozilla-sops/).

I'll be using secrets are managed using [Mozilla SOPS](https://github.com/mozilla/sops) and encrypted with [age](https://github.com/FiloSottile/age),

