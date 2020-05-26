# Agorakube Parameters

Below  you can find all the parameters you can use in this file, section by section.

### Certificates section

This section is used to custom certificates information.

| Parameter | Description | Values |
| --- | --- | --- |
| `cn_root_ca` | Certificate authority name | <ul><li> **Depend on your deployment** </li><br/><li>  **ilkilabs** *(default)* </li></ul>|
| `c` | Country where the certificate is issued | <ul><li> **Depend on your deployment** </li><br/><li>  **FR** *(default)* </li></ul>|
| `st` | State where the certificate is issued | <ul><li> **Depend on your deployment** </li><br/><li>  **Ile-de-France** *(default)* </li></ul>|
| `l` | City where the certificate is issued | <ul><li> **Depend on your deployment** </li><br/><li>  **Paris** *(default)* </li></ul>|
| `expiry` | Certificate lifetime in hours | <ul><li> **Depend on your needs** </li><br/><li>  **87600h** *(default)* </li></ul>|
| `rotate_full_pki` | Update all the PKI (crts, keys and crs) of your cluster. You will need to regenerate manually your Service Account Tokens, and relaunch all pods that are using them | <ul><li> **false** *(default)* </li><br/><li>  **true** </li></ul>|
| `rotate_certs_pki` | Rotate certificates for your cluster | <ul><li> **false** *(default)* </li><br/><li>  **true** </li></ul>|
### Components version section

This section is used to custom the components version of your deployment.

| Parameter | Description | Values |
| --- | --- | --- |
| `etcd_release` | Version of etcd component | <ul><li> **3.3.X** or **3.4.X** </li><br/><li>  **3.4.5** *(default)* </li></ul>|
| `kubernetes_release` | Version of kubernetes components | <ul><li> **1.15.X**, **1.16.X**, **1.17.X** or **1.18.X** </li><br/><li>  **1.18.0** *(default)* </li></ul>|
| `delete_previous_k8s_install` | Deletion of previous installations of Kubernetes | <ul><li> **true** </li><br/><li>  **false** *(default)* </li></ul>|

### IPs-CIDR Configurations

This section is used to custom network configurations of your deployment.

**Note :** It will depend on the CNI plugin used.

| Parameter | Description | Values |
| --- | --- | --- |
| `cluster_cidr` | CIDR used for all pods deployed in your cluster | <ul><li> **Depend on your deployment** </li><br/><li>  **10.33.0.0/16** *(default)* </li></ul>|
| `service_cluster_ip_range` | CIDR used for all services deployed in your cluster | <ul><li> **Depend on your deployment** </li><br/><li>   **10.32.0.0/16** *(default)* </li></ul>|
| `kubernetes_service` | IP used for Kubernetes service of your cluster. **Must be** the first IP of your service CIDR ! | <ul><li> **Depend on your deployment** </li><br/><li>  **10.32.0.1** *(default)* </li></ul>|
| `cluster_dns_ip` | IP used for DNS services deployed in your cluster | <ul><li> **Depend on your deployment** </li><br/><li>  **10.32.0.10** *(default)* </li></ul>|
| `service_node_port_range` | Range of ports used for all NodePort services deployed in your cluster | <ul><li> **depend on your deployment** </li><br/><li>   **30000-32767** *(default)* </li></ul>|
| `kube_proxy_mode` | Configure kube-proxy mode | <ul><li> **ipvs (default)** </li><br/><li>   **iptables** </li><br/><li>   **userspace**</li></ul>|
| `kube_proxy_ipvs_algotithm` | Load Balancing algorithm for *IPVS Kube-proxy* mode | <ul><li> **rr** *(default - round-robin)*</li><br/><li>   **lc** (least connection) </li><br/><li>   **dh** *(destination hashing)* </li><br/><li>   **sh** *(source hashing)* </li><br/><li>   **sed** *(shortest expected delay)* </li><br/><li>   **nq** *(never queue)* </li></ul>|

### Custom features section

This section is used to defined all custom features of your deployment.

| Parameter | Description | Values |
| --- | --- | --- |
| `runtime` | Container runtime used in your deployment | <ul><li> **containerd** *(default)* </li><br/><li>  **docker**  </li></ul>|
| `network_cni_plugin` | CNI plugin used in your deployment | <ul><li> **calico** </li><br/><li> **flannel** </li><br/><li>  **kube-router** *(default)* </li></ul>|
| `flannel_iface` | Indicate to Flannel the specific iface to be binded | <ul><li> **default** *(default - take the first iface)* </li><br/><li>  **Specific Iface**</li></ul>|
| `ingress_controller` | Ingress Controller used in your deployment | <ul><li> **traefik** *(default)* </li><br/><li>  **ha-proxy**  </li><br/><li>  **nginx**  </li><br/><li>  **none**  </li></ul>|
| `dns_server_soft` | DNS service used in your deployment | <ul><li> **CoreDNS** *(default)* </li></ul>|
| `label_workers` | Fixed the label *node-role.kubernetes.io/worker* to all workers in your cluster | <ul><li> **false** </li><br/><li>  **true** *(default)* </li></ul>|
| `populate_etc_hosts` | Populate */etc/hosts* file of all your nodes in the cluster | <ul><li> **no** </li><br/><li>  **yes** *(default)* </li></ul>|
| `k8s_dashboard` | Deploy Kubernetes dashboard in your cluster | <ul><li> **false** </li><br/><li>  **true** *(default)* </li></ul>|
| `service_mesh` | Service mesh used in your cluster | <ul><li> **none** *(default)* </li><br/><li>  **linkerd** </li></ul>|
| `linkerd_release` | Version of LinkerD used in your cluster | <ul><li> **stable-2.6.0** *(default)* </li><br/><li>  **none** </li></ul>|
| `install_helm` | Helm installation in your cluster | <ul><li> **false** *(default)* </li><br/><li>  **true** </li></ul>|
| `init_helm` | Initialization of Helm | <ul><li> **false** *(default)* </li><br/><li>  **true** </li></ul>|
| `install_kubeapps` | Installation of Kubeapps - **install_helm** and **init_helm** have to be **true** also. | <ul><li> **false** *(default)* </li><br/><li>  **true** </li></ul>|

### Other parameters sections

Parameters for Calico CNI plugin :

| Parameter | Description | Values |
| --- | --- | --- |
| `calico_mtu` | MTU size to used in your deployment | <ul><li> **Depend on your needs** </li><br/><li>  **1440** *(default)* </li></ul>|

Parameters for etcd :

| Parameter | Description | Values |
| --- | --- | --- |
| `encrypt_etcd_keys` | Encryption keys used for etcd - Dictionary format | <ul><li> **Depend on your deployment** </li><br/><li>  **1fJcKt6vBxMt+AkBanoaxFF2O6ytHIkETNgQWv4b/+Q=** *(default)* </li></ul> |
| `check_etcd_install` | Display ETCD infos | <ul><li> **True** (Default) </li><br/><li>  False </li></ul> |

Parameters for Agorakube datas storage :

| Parameter | Description | Values |
| --- | --- | --- |
| `data_path` | Path to Agorakube datas directory | <ul><li> **Depend on your deployment** </li><br/><li> **"/var/agorakube"** *(default)* </li></ul> |

Parameters for etcd data location, and backups

| Parameter | Description | Values |
| --- | --- | --- |
| `etcd_data_directory` | Directory to store etcd data on **etcd members** | <ul><li> **/var/lib/etcd/** (default) </li><br/></ul> |
| `custom_etcd_backup_dir` | Directory where etcd leader backups are stored on **deploy** node | <ul><li> **{{data_path}}/backups_etcd/** (default if not defined) </li><br/></ul> |
| `restoration_snapshot_file` | Path to the etcd snapshot on **deploy** node | <ul><li> **not defined** (default) </li><br/></ul> |

Rook Settings

| Parameter | Description | Values |
| --- | --- | --- |
| `enable_rook` | Deploy Rook Ceph cluster on **storage members** | <ul><li> **False** (default) </li><br/><li>  **True** </li></ul> |
| `rook_dataDirHostPath` | Directory where Rook data are stored on **Storage** nodes | <ul><li> **/data/rook** (default) </li><br/></ul> |
| `enable_rook_minio` | Deploy Rook MinIO cluster on **Rook Ceph Cluster** | <ul><li> **False** (default) </li><br/><li>  **True** </li></ul> |
| `rook_minio_infra_access_key` | MinIO Admin Access Key | <ul><li> **admin_minio** (default) </li><br/></ul> |
| `rook_minio_infra_secret_key` | MinIO Admin Secret Key | <ul><li> **password_minio** (default) </li><br/></ul> |


Harbor Settings

| Parameter | Description | Values |
| --- | --- | --- |
| `install_harbor` | Deploy Harbor Registry - Warrning : **Rook Must be enabled !** | <ul><li> **False** (default) </li><br/><li>  **true** </li></ul> |
| `harbor_admin_password` | Admin password for Harbor UI | <ul><li> **ChangeMe!** (default) </li></ul> |
| `harbor_ingress_host` | Host entry in Ingress. Harbor will be expose at **https://{{ harbor_ingress_host }}** (Depend on your ingress configuration) | <ul><li> harbor.ilkilabs.io (default) </li></ul> |
| `notary_ingress_host` | Host entry in Ingress. Notary will be expose at **https://{{ notary.ilkilabs.io }}** (Depend on your ingress configuration) | <ul><li> **notary.ilkilabs.io** (default) </li></ul> |

Monitoring Settings

| Parameter | Description | Values |
| --- | --- | --- |
| `enable_monitoring` | Deploy monitoring - Warrning : **Rook Must be enabled !** | <ul><li> **False** (default) </li><br/><li>  **true** </li></ul> |


Others settings:

| Parameter | Description | Values |
| --- | --- | --- |
| `kube_apiserver_enable_admission_plugins` | List of admission plugins to be enabled | <ul><li> **Depend on your deployment** </li><br/></ul> |
