# Managing the cluster with Flux CD

I use [Flux](https://fluxcd.io/) to manage the software in my cluster.

Flux natively supports Mozilla SOPS, see the [Flux document](https://fluxcd.io/flux/guides/mozilla-sops/).

I use [Mozilla SOPS](https://github.com/mozilla/sops) to manage secrets, they are encrypted with
[age](https://github.com/FiloSottile/age) which means they can be pushed to my git repositories.

