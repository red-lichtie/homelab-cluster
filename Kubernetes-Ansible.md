# Using Ansible to install Kubernetes

The project [k3s-ansible](https://github.com/techno-tim/k3s-ansible) from Tim Stewart is used to provision the
kubernetes cluster. 

I'm sure this could also be done using Terraform, but I have split it into 2 distinct operations.

## Get and install ansible

Getting and installing Ansible is [documented on their website](https://docs.ansible.com/ansible/latest/).

## Clone Tim's project

```shell
export K3S_ANSIBLE_REPO=$HOME/github-repos/k3s-ansible
mkdir -p ${K3S_ANSIBLE_REPO}
git clone https://github.com/techno-tim/k3s-ansible.git ${K3S_ANSIBLE_REPO}
```

## Set up the inventory

See the [inventory files](files/kubernetes-ansible/inventory/test-cluster) for an example configuration.

## Running the playbook
```shell
export K3S_ANSIBLE_REPO=$HOME/github-repos/k3s-ansible
ansible-playbook \
  -i files/kubernetes-ansible/inventory/test-cluster/hosts.ini \
  --extra-vars files/kubernetes-ansible/inventory/test-cluster/group_vars/all.yml \
  ${K3S_ANSIBLE_REPO}/site.yml
```

Once completed you can connect to one of the control nodes and check out the cluster.

Set the configuration file to be used
```shell
kubeadm@kubernetes-test-c1:~$ export KUBECONFIG=/home/kubeadm/.kube/config
```

List the nodes
```shell
kubeadm@kubernetes-test-c1:~$ kubectl get nodes -o wide
NAME                 STATUS   ROLES                       AGE   VERSION         INTERNAL-IP       EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION    CONTAINER-RUNTIME
kubernetes-test-a1   Ready    <none>                      11m   v1.24.10+k3s1   192.168.122.221   <none>        Ubuntu 22.10   5.19.0-1016-kvm   containerd://1.6.15-k3s1
kubernetes-test-a2   Ready    <none>                      11m   v1.24.10+k3s1   192.168.122.222   <none>        Ubuntu 22.10   5.19.0-1018-kvm   containerd://1.6.15-k3s1
kubernetes-test-a3   Ready    <none>                      11m   v1.24.10+k3s1   192.168.122.223   <none>        Ubuntu 22.10   5.19.0-1016-kvm   containerd://1.6.15-k3s1
kubernetes-test-c1   Ready    control-plane,etcd,master   13m   v1.24.10+k3s1   192.168.122.211   <none>        Ubuntu 22.10   5.19.0-1016-kvm   containerd://1.6.15-k3s1
kubernetes-test-c2   Ready    control-plane,etcd,master   12m   v1.24.10+k3s1   192.168.122.212   <none>        Ubuntu 22.10   5.19.0-1016-kvm   containerd://1.6.15-k3s1
kubernetes-test-c3   Ready    control-plane,etcd,master   13m   v1.24.10+k3s1   192.168.122.213   <none>        Ubuntu 22.10   5.19.0-1016-kvm   containerd://1.6.15-k3s1
```

List the pods
```shell
kubeadm@kubernetes-test-c1:~$ kubectl get pods -o wide --all-namespaces
NAMESPACE        NAME                                      READY   STATUS    RESTARTS      AGE   IP                NODE                 NOMINATED NODE   READINESS GATES
kube-system      coredns-7b5bbc6644-gpmnn                  1/1     Running   1 (14m ago)   14m   10.42.0.6         kubernetes-test-c1   <none>           <none>
kube-system      kube-vip-ds-ccmpw                         1/1     Running   1 (14m ago)   14m   192.168.122.211   kubernetes-test-c1   <none>           <none>
kube-system      kube-vip-ds-wdwp2                         1/1     Running   0             14m   192.168.122.212   kubernetes-test-c2   <none>           <none>
kube-system      kube-vip-ds-xhh7r                         1/1     Running   1 (14m ago)   14m   192.168.122.213   kubernetes-test-c3   <none>           <none>
kube-system      local-path-provisioner-687d6d7765-9xjzv   1/1     Running   1 (14m ago)   14m   10.42.0.5         kubernetes-test-c1   <none>           <none>
kube-system      metrics-server-667586758d-94c7h           1/1     Running   1 (14m ago)   14m   10.42.0.7         kubernetes-test-c1   <none>           <none>
metallb-system   controller-6c58495cbb-47prr               1/1     Running   0             14m   10.42.4.2         kubernetes-test-a3   <none>           <none>
metallb-system   speaker-4w7pr                             1/1     Running   0             13m   192.168.122.222   kubernetes-test-a2   <none>           <none>
metallb-system   speaker-cdtq5                             1/1     Running   0             14m   192.168.122.212   kubernetes-test-c2   <none>           <none>
metallb-system   speaker-gtfg4                             1/1     Running   0             13m   192.168.122.223   kubernetes-test-a3   <none>           <none>
metallb-system   speaker-skd4g                             1/1     Running   0             14m   192.168.122.213   kubernetes-test-c3   <none>           <none>
metallb-system   speaker-t6ztr                             1/1     Running   0             13m   192.168.122.221   kubernetes-test-a1   <none>           <none>
metallb-system   speaker-vr2bm                             1/1     Running   0             14m   192.168.122.211   kubernetes-test-c1   <none>           <none>
```
