
virtualmachines = {
  talos-node-1 = {
    vmid = 501
    instance_label = "Talos Production - Controller 1"
    instance_name = "talos-c1"
    instance_drive_size = "15G"
    instance_memory_kb = 6144
    target_node = "pvepr0"
    macaddr = "0a:69:39:6d:e0:c9" # 		192.168.77.101 	talos-c1
  }
  talos-node-2 = {
    vmid = 551
    instance_label = "Talos Production - Agent 1"
    instance_name = "talos-a1"
    instance_drive_size = "80G"
    instance_memory_kb = 16384
    target_node = "pvepr0"
    macaddr = "06:ae:38:9d:61:bb" # 		192.168.77.151 	talos-a1
  }
  talos-node-3 = {
    vmid = 502
    instance_label = "Talos Production - Controller 2"
    instance_name = "talos-c2"
    instance_drive_size = "15G"
    instance_memory_kb = 6144
    target_node = "pvepr1"
    macaddr = "6e:ba:64:73:96:7d" # 		192.168.77.102 	talos-c2
  }
  talos-node-4 = {
    vmid = 552
    instance_label = "Talos Production - Agent 2"
    instance_name = "talos-a2"
    instance_drive_size = "80G"
    instance_memory_kb = 16384
    target_node = "pvepr1"
    macaddr = "d6:b0:d8:e1:e1:9e" # 		192.168.77.152 	talos-a2
  }
  talos-node-5 = {
    vmid = 503
    instance_label = "Talos Production - Controller 3"
    instance_name = "talos-c3"
    instance_drive_size = "15G"
    instance_memory_kb = 6144
    target_node = "pvepr2"
    macaddr = "62:80:c2:36:9c:39" # 		192.168.77.103 	talos-c3
  }
  talos-node-6 = {
    vmid = 553
    instance_label = "Talos Production - Agent 3"
    instance_name = "talos-a3"
    instance_drive_size = "80G"
    instance_memory_kb = 16384
    target_node = "pvepr2"
    macaddr = "82:02:59:dc:b5:ab" # 		192.168.77.153 	talos-a3
  }
}
