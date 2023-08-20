# SBU DCAI
Distributed Computing for Artificial Intellegence over k8s.
## 📖 Table of Contents
- [Network & Internet setup](#network--internet-setup)
- [Gitlab](#gitlab)
- [Monitoring](#monitoring)
  - [Prometheus](#prometheus)
  - [Grfana](#grafana)
  - [cAdvisor](#cadvisor)
  - [Node Exporter](#node-exporter)
- [Kubernetes setup](#kubernetes-setup)
- [GPU configuration for K8s](#gpu-configuration-for-k8s)
  - [Node Feature Discovery (NFD)](#node-feature-discovery-nfd)
  - [Nvidia GPU operator](#nvidia-gpu-operator)
- [Sub Admin access](#sub-admin-access)
- [Cluster Backup](#cluster-backup)
- [Private Docker Registry](private-docker-registry)
## Network & Internet setup
The following [file](https://github.com/mohsenkamini/SBU-DCAI/blob/main/network/hotspot.sh) will provide complete internet connection on hosts.

Make it run frequently:
~~~
cp ./network/hotspot.sh /bin/hotspot.sh
chown root:root /bin/hotspot.sh
chmod 700 /bin/hotspot.sh
echo "*/30 * * * * root /bin/bash /bin/hotspot.sh" > /etc/cron.d/hotspot
apt update
apt install -y sshuttle
~~~

## Gitlab

## Monitoring

This [file](https://github.com/mohsenkamini/SBU-DCAI/blob/milad/userObjects/monitoring/docker-compose.yml) will run docker compose for Prometheus, Grafana and cAdvisor.

### Prometheus

Configuration file is in /etc/prometheus/[prometheus.yml](https://github.com/mohsenkamini/SBU-DCAI/blob/milad/userObjects/monitoring/prometheus/prometheus.yml)

### Grafana

Add new Connection for Prometheus in Home > Connections > Data sources > Prometheus :

http://prometheus:9090

### cAdvisor

Use this [repo](https://github.com/google/cadvisor).

### Node exporter

for Node Exporter run this :

~~~
wget https://github.com/prometheus/node_exporter/releases/download/v*/node_exporter-*.*-amd64.tar.gz #replace version
tar xvfz node_exporter-*.*-amd64.tar.gz #replace version
cd node_exporter-*.*-amd64 #replace version
./node_exporter
~~~

You can also use this [repo](https://github.com/prometheus/node_exporter).

## Kubernetes setup

Created initial cluster using this [repo](https://github.com/mohsenkamini/Getting-started-w-Kubernetes).

## GPU configuration for K8s

### Node Feature Discovery (NFD)
Installed using this [repo](https://github.com/kubernetes-sigs/node-feature-discovery).

### Nvidia GPU operator
These are the needed documents to implement gpu operator:
- [overview](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/gpu-operator)
- [about the nvidia gpu operator](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/gpu-operator)
- [getting started](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html)

## Sub Admin access
The `userObjects` directory contains any kubernetes objects that are created by us. The access for a subAdmin is granted with roles and cluster roles within the [subAdmin directory](./userObjects/subAdmin).

The certificates are handled within the [certificates directory](./userObjects/certificates)

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

