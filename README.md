# SBU DCAI
Distributed Computing for Artificial Intellegence over k8s.
## 📖 Table of Contents
- [Network & Internet setup](#network--internet-setup)
- [Kubernetes setup](#kubernetes-setup)
- [GPU configuration for K8s](#gpu-configuration-for-k8s)
  - [Drivers](#drivers)
  - [Node Feature Discovery (NFD)](#node-feature-discovery-nfd)
  - [Nvidia GPU operator](#nvidia-gpu-operator)
- [Sub Admin access](#sub-admin-access)
- [Cluster Backup](#cluster-backup)
- [Monitoring](#monitoring)
- [Private Docker Registry](private-docker-registry)
## Network & Internet setup
The following [file](./network/hotspot.sh) will provide complete internet connection on hosts.

Do this:
~~~
cp ./network/hotspot.sh ./network/.hotspot.sh
vi ./network/.hotspot.sh
~~~
Add proper credentials to it, and run the following to setup network on nodes using `ansible`:
~~~
cd ./ansible/
vi inventory
~~~
An example for inventory could be like this: 
~~~
[masters]
master1 ansible_host=master1.sbu-dcai.ir

[workers]
worker01 ansible_host=worker01.sbu-dcai.ir
worker02 ansible_host=worker02.sbu-dcai.ir

[others]
registry ansible_host=registry.sbu-dcai.ir
monitoring ansible_host=monitoring.sbu-dcai.ir

[all:vars]
host_key_checking = false
ansible_user=CHANGEME
ansible_ssh_port=CHANGEME
ansible_become=yes
ansible_ssh_private_key_file=CHANGEME
~~~
And finally: 
~~~
ansible-playbook -i ./inventory ./plays/network-setup.yml
~~~

## Kubernetes setup

Created initial cluster using this [repo](https://github.com/mohsenkamini/Getting-started-w-Kubernetes).

## GPU configuration for K8s

### Drivers
Before adding a worker node with GPU on it, install nvidia drives using `apt`. You read more on that on [this article](https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-20-04-focal-fossa-linux).

Finally test if everything is ready:
~~~
nvidia-smi
~~~

### Node Feature Discovery (NFD)
Installed using this [repo](https://github.com/kubernetes-sigs/node-feature-discovery).

### Nvidia GPU operator
These are the needed documents to implement gpu operator:
- [overview](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/gpu-operator)
- [about the nvidia gpu operator](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/gpu-operator)
- [getting started](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html)

~~~
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh
~~~
~~~
helm repo add nvidia https://helm.ngc.nvidia.com/nvidia \
    && helm repo update
~~~
~~~
helm install --debug --wait --generate-name --timeout 50m \
     -n gpu-operator --create-namespace      nvidia/gpu-operator
~~~


## Sub Admin access
The `userObjects` directory contains any kubernetes objects that are created by us. The access for a subAdmin is granted with roles and cluster roles within the [subAdmin directory](./userObjects/subAdmin).

The certificates are handled within the [certificates directory](./userObjects/certificates)

## Monitoring

You can use this [repo](https://github.com/Mi-Kho/monitoring.git).

## Cluster Backup
The scripts to get backups are in [this directory](./backup/). currently only support a `kubectl get all -A` as backup.

make that run frequently:
~~~
cp ./backup/* /usr/bin/
echo "48 23 * * * root /usr/bin/cluster-get-all-backup.sh /usr/share/backups/get-all/
49 23 * * 5 root /usr/bin/keep-n-backups.sh /usr/share/backups/get-all/ 8 " > /etc/cron.d/backup
~~~

## Private Docker Registry
To use images in private registry do as following:
~~~
docker pull <image> # pull the image locally
docker image tag <image> registry.mohsenkamini.ir:5000/<image>
docker image push registry.mohsenkamini.ir:5000/<image> # push it to the private reg
~~~
