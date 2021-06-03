## Inventory file

The first file to modify is ["./hosts"](../hosts). This file contains all architecture information about your K8S Cluster.

**All K8S servers names must be filled in by their FQDN.**

The next Sample deploys K8S components in HA mode on 6 nodes (3 **etcd/masters** nodes, 3 **workers** nodes and 3 **storage** nodes) :

```
[deploy]
master1 ansible_connection=local

[masters]
master1  ansible_host=10.10.20.3
master2  ansible_host=10.10.20.13
master3  ansible_host=10.10.20.23

[etcd]
master1  ansible_host=10.10.20.3
master2  ansible_host=10.10.20.13
master3  ansible_host=10.10.20.23

[workers]
worker1  ansible_host=10.10.20.4
worker2  ansible_host=10.10.20.5
worker3  ansible_host=10.10.20.6


[storage]
worker1 ansible_host=10.10.20.4
worker2 ansible_host=10.10.20.5
worker3 ansible_host=10.10.20.6

[all:vars]
advertise_ip_masters=10.10.20.3

# SSH connection settings
ansible_ssh_extra_args='-o StrictHostKeyChecking=no'
ansible_user=vagrant
ansible_ssh_private_key_file=/home/vagrant/ssh-private-key.pem
```

The **deploy** section contains information about how to connect to the deployment machine.

The **etcd** section contains information about the etcd machine(s) instances.

The **masters** section contains information about the masters nodes (K8S Control Plane).

The **workers** section contains information about the workers nodes (K8S Data Plane).

The **all:vars** section contains information about how to connect to K8S nodes.

The **SSH Connection settings** section contain information about the SSH connexion. You have to modify the variable **ansible_ssh_private_key_file** with the path where your public key is stored.
**ansible_user** User used as service account by Agorakube to connect to all nodes. **User must be sudoer**.

## Configuration file

The [../group_vars/all.yaml](../group_vars/all.yaml) file contains all configuration variables that you can customize to make your K8S Cluster fit your needs.

Sample file will deploy **containerd** as container runtime, **flannel** as CNI plugin and **coredns** as DNS service : 

```
---

# CERTIFICATES
cn_root_ca: ilkilabs
c: FR
st: Ile-De-France
l: Paris
expiry: 87600h
rotate_certs_pki: false
rotate_full_pki: false

# Components version
etcd_release: v3.4.7
kubernetes_release: v1.18.2
delete_previous_k8s_install: False
delete_etcd_install: False
check_etcd_install: True

# IPs-CIDR Configurations
cluster_cidr: 10.33.0.0/16
service_cluster_ip_range: 10.32.0.0/24
kubernetes_service: 10.32.0.1
cluster_dns_ip: 10.32.0.10
service_node_port_range: 30000-32000
kube_proxy_mode: ipvs
kube_proxy_ipvs_algotithm: rr
cni_release: 0.8.5

# Custom features
runtime: containerd
network_cni_plugin: kube-router
flannel_iface: default
ingress_controller: nginx
dns_server_soft: coredns
populate_etc_hosts: yes
k8s_dashboard: True
service_mesh: none
linkerd_release: stable-2.6.0
install_helm: False
init_helm: False
install_kubeapps: False

# Calico
calico_mtu: 1440

# Security
encrypt_etcd_keys:
# Warrning: If multiple keys are defined ONLY LAST KEY is used for encrypt and decrypt.
# Other keys are used only for decrypt purpose
  key1:
    secret: 1fJcKt6vBxMt+AkBanoaxFF2O6ytHIkETNgQWv4b/+Q=

# Data Directory
data_path: "/var/agorakube"
etcd_data_directory: "/var/lib/etcd"
#restoration_snapshot_file: /path/snopshot/file Located on {{ etcd_data_directory }}

# KUBE-APISERVER spec
kube_apiserver_enable_admission_plugins:
# plugin AlwaysPullImage can be deleted. Credentials would be required to pull the private images every time. 
# Also, in trusted environments, this might increases load on network, registry, and decreases speed.
#  - AlwaysPullImages
  - NamespaceLifecycle
# EventRateLimit is used to limit DoS on API server in case of event Flooding
  - EventRateLimit
  - LimitRanger
  - ServiceAccount
  - TaintNodesByCondition
  - PodNodeSelector
  - Priority
  - DefaultTolerationSeconds
  - DefaultStorageClass
  - StorageObjectInUseProtection
  - PersistentVolumeClaimResize
  - MutatingAdmissionWebhook
  - NodeRestriction
  - ValidatingAdmissionWebhook
  - RuntimeClass
  - ResourceQuota
# SecurityContextDeny should be replaced by PodSecurityPolicy
#  - SecurityContextDeny


# Rook Settings
enable_rook: True
rook_dataDirHostPath: /data/rook

# Minio Settings
# Rook MUST be enabed.
enable_rook_minio: True
rook_minio_infra_access_key: admin
rook_minio_infra_secret_key: password

# Monitoring. Rook MUST be enabled to use monitoring (Monitoring use StorageClass to persist data)
enable_monitoring: False


# Enable Harbor Registry - Contain Chartmuseum, notary, clair, registry.
# Harbor will be expose by HTTPS with Ingress Resource.
# Rook MUST be enabled to use Harbor (Harbor use StorageClass to persist data)
install_harbor: False
harbor_ingress_host: harbor.ilkilabs.io
notary_ingress_host: notary.ilkilabs.io
harbor_admin_password: ChangeMe!
```

**Note :** You can also modify the IPs-CIDR if you want.
