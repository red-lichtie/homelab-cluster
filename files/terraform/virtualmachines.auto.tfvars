virtualmachines = {
  k8snode-1 = {
    vmid = 1001
    instance_label = "Kubernetes Test - Controller 1"
    instance_hostname = "kubernetes-test-c1"
    ipconfig0 = "gw=192.168.122.1,ip=192.168.122.211/24"
    instance_drive_size = "5G"
    instance_memory_kb = 3072
    target_node = "pvetest1"
  }
  k8snode-2 = {
    vmid = 1002
    instance_label = "Kubernetes Test - Controller 2"
    instance_hostname = "kubernetes-test-c2"
    ipconfig0 = "gw=192.168.122.1,ip=192.168.122.212/24"
    instance_drive_size = "5G"
    instance_memory_kb = 3072
    target_node = "pvetest2"
  }
  k8snode-3 = {
    vmid = 1003
    instance_label = "Kubernetes Test - Controller 3"
    instance_hostname = "kubernetes-test-c3"
    ipconfig0 = "gw=192.168.122.1,ip=192.168.122.213/24"
    instance_drive_size = "5G"
    instance_memory_kb = 3072
    target_node = "pvetest3"
  }
  k8snode-4 = {
    vmid = 1004
    instance_label = "Kubernetes Test - Agent 1"
    instance_hostname = "kubernetes-test-a1"
    ipconfig0 = "gw=192.168.122.1,ip=192.168.122.221/24"
    instance_drive_size = "5G"
    instance_memory_kb = 6144
    target_node = "pvetest1"
  }
  k8snode-5 = {
    vmid = 1005
    instance_label = "Kubernetes Test - Agent 2"
    instance_hostname = "kubernetes-test-a2"
    ipconfig0 = "gw=192.168.122.1,ip=192.168.122.222/24"
    instance_drive_size = "5G"
    instance_memory_kb = 6144
    target_node = "pvetest2"
  }
  k8snode-6 = {
    vmid = 1006
    instance_label = "Kubernetes Test - Agent 3"
    instance_hostname = "kubernetes-test-a3"
    ipconfig0 = "gw=192.168.122.1,ip=192.168.122.223/24"
    instance_drive_size = "5G"
    instance_memory_kb = 6144
    target_node = "pvetest3"
  }
}