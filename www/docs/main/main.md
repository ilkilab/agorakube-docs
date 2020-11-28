## What is AgoraKube

[AgoraKube](https://agorakube.ilkilabs.io/) is an easy-to-use, stable Kubernetes distribution (Kubernetes v1.15, 1.16, 1.17, 1.18, v1.19).

By its symplicity, [AgoraKube](https://agorakube.ilkilabs.io/) provide a good way to deploy and manage K8S Clusters.

[AgoraKube](https://agorakube.ilkilabs.io/) is based on Ansible scripts that install and configure Kubernetes components (control plane and data plane) quickly on bare-metal / VMs / Cloud Instances, as systemd services.

This distribution is also adaptive by offering the opportunity to customize your deployment and fit to your needs :

* OS : Ubuntu-18.04/20.04-amd64 , Centos 7.X-amd64 and Debian 10
* DNS Service: CoreDNS
* Ingress Controller Traefik (Default) & HA-Proxy & Nginx
* Container Runtime: Containerd (Default) & Docker
* Certificats: Self Signed PKI
* Service-Mesh: available: Linkerd
* Storage: Rook Ceph Block with StorageClass, and MinIO for Object Storage
* Registry: Harbor full featured
* Monitoring: Prometheus/Grafana
* CNI plugin: Flannel, Calico, Kube-router
* Packaging: Helm
* Self service application portal: Kubeapps
* ...

This project is currently under active development so other customizable options will be added soon.

## How to install

We regularly use a machine to deploy every cluster. We only use it for deployment.

### Setup

#### On the "deployment" node
Execute this command in order to install Ansible and clone the repository :
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube/master/setup-deploy.sh)
```
#### On the K8S nodes
Execute this command on each node to update them and install the last version of Python : 
```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/agorakube/master/setup-hosts.sh)
```

### Installation instructions

To deploy your K8S cluster follow these [instructions](./instructions.md).

## How to give feedback

Every feedback is very welcome via the
[GitHub site](https://github.com/ilkilab/agorakube)
as issues or pull (merge) requests.

You can also give use vulnerability reports by this way.
## How to contribute

See our [Code Of Conduct](https://github.com/ilkilab/agorakube/blob/master/CODE_OF_CONDUCT.md) and [CONTRIBUTING](https://github.com/ilkilab/agorakube/blob/master/docs/CONTRIBUTING.md) for more information.

## Community

Join Agorakube's community for discussion and ask questions : [Agorakube's Slack](http://slack.agorakube.ilkilabs.io/)

* **#random** - As its name suggests, for random discussions :)

## Licensing

All material here is released under the [APACHE 2.0 license](../about/license.md). All material that is not executable, including all text when not executed, is also released under the APACHE 2.0. In SPDX terms, everything here is licensed under APACHE 2.0; if it's not executable, including the text when extracted from code, it's "(APACHE 2.0)". 

Like almost all software today, this software depends on many other components with their own licenses. Not all components we depend on are APACHE 2.0-licensed, but all *required* components are FLOSS.
