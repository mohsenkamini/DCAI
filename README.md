# SBU DCAI
Distributed Computing for Artificial Intellegence over k8s.

### Network & Internet setup
The following [file](https://github.com/mohsenkamini/SBU-DCAI/blob/main/network/hotspot.sh)(./network/hotspot.sh) will provide complete internet connection on hosts.

Make it run frequently:
~~~
cp ./network/hotspot.sh /bin/hotspot.sh
chown root:root /bin/hotspot.sh
chmod 700 /bin/hotspot.sh
echo "*/30 * * * * root /bin/bash /bin/hotspot.sh" > /etc/cron.d/hotspot
~~~

### Kubernetes setup

Created initial cluster using this [repo](https://github.com/mohsenkamini/Getting-started-w-Kubernetes).

### GPU configuration for K8s

#### Node Feature Discovery (NFD)
Installed using this [repo](https://github.com/kubernetes-sigs/node-feature-discovery).

#### Nvidia GPU operator
These are the needed documents to implement gpu operator:
- [overview](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/gpu-operator)
- [about the nvidia gpu operator](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/gpu-operator)
- [getting started](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html)

### Sub Admin access
The `userObjects` directory contains any kubernetes objects that are created by us. The access for a subAdmin is granted with roles and cluster roles within the [subAdmin directory](https://github.com/mohsenkamini/SBU-DCAI/tree/main/userObjects/subAdmin).

The certificates are handled within the [certificates directory](https://github.com/mohsenkamini/SBU-DCAI/tree/main/userObjects/certificates)

### Cluster Backup

~~~
48 23 * * * /usr/bin/cluster-get-all-backup.sh /usr/share/backups/get-all/
49 23 * * 5 /usr/bin/keep-n-backups.sh /usr/share/backups/get-all/ 8
~~~
