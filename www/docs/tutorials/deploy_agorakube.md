In this tutorial, we will use virtual machines that will be created by vagrant using VirtualBox.

[Vagrant](https://www.vagrantup.com/) is an orchestration tool for building and managing virtual machine environments in a single workflow.

[VirtualBox](https://www.virtualbox.org/) is an Hypervisor Type 2 and it is used to provision Virtual Machines localy.

# Deploy the environment

If you want to deploy the same Kubernetes cluster as this tutorial you will need at least a host with 12GB of RAM, but you can adapt it.

The cluster will be composed of 4 Virtual machines.

* 1 machine Deploy that will be used as a deployment machine. With this machine, you can pilot your Kubernetes cluster if you want.
* 1 machine master/worker, this machine will have the role of master and worker also
* 1 machine worker
* 1 machine etcd

> *"Note: If you don't have enough RAM for this tutorial, we suggest deploying an all-in-one cluster (1 machine with all roles). A Vagrantfile is provided for this in the project Agorakube in **./test_lab**."*

Below you have the Vagrantfile used for this tutorial. We are using 4 machines Ubuntu 18.04. You are free to change the OS to CentOS 7 if you want.

* Create a file named "Vagrantfile" with the following content:

```ruby
#
#	Vagrantfile
#

$vagrant_box = "bento/ubuntu-18.04"

Vagrant.configure("2") do |config|
  config.vm.define "master" do |master|
      master.vm.box = $vagrant_box
      master.vm.network :private_network, ip: "10.0.0.11"
      master.vm.hostname = "master"
      master.vm.provider "virtualbox" do |vb|
          vb.customize ["modifyvm", :id, "--memory", 2048]
          vb.customize ["modifyvm", :id, "--name", "master"] 
      end
  end
  config.vm.define "worker" do |worker|
      worker.vm.box = $vagrant_box
      worker.vm.network :private_network, ip: "10.0.0.12"
      worker.vm.hostname = "worker"
      worker.vm.provider "virtualbox" do |vb|
          vb.customize ["modifyvm", :id, "--memory", 2048]
          vb.customize ["modifyvm", :id, "--name", "worker"] 
      end
  end
  config.vm.define "etcd" do |etcd|
    etcd.vm.box = $vagrant_box
    etcd.vm.network :private_network, ip: "10.0.0.13"
    etcd.vm.hostname = "etcd"
    etcd.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", 2048]
        vb.customize ["modifyvm", :id, "--name", "etcd"] 
    end
end
  config.vm.define "deploy" do |deploy|
      deploy.vm.box = $vagrant_box
      deploy.vm.network :private_network, ip: "10.0.0.10"
      deploy.vm.hostname = "deploy"
      deploy.vm.provider "virtualbox" do |vb|
          vb.customize ["modifyvm", :id, "--memory", 1024]
          vb.customize ["modifyvm", :id, "--name", "deploy"] 
      end
  end
end
```


## Installation of VMs used in this tutorial

If you want to use the same method of deployment as this tutorial follow those steps.

* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
	* This is necessary to use a version of VirtualBox supported by Vagrant otherwise you will not have the possibility to use the Vagrantfile.
* Install [Vagrant](https://www.vagrantup.com/downloads.html)
	* You can install the latest version
* Deploy the cluster with the Vagrantfile provided below
	* To deploy with the Vagrantfile, create a file Vagrantfile (with no extension!) with the script below
	* Open a command line in the path of this file
	* Use the command ```vagrant up``` (it will start the installation of your machine)
* You can connect to your VM using vagrant ssh nameofthemachine
	* If you want to stop your cluster use the command vagrant halt
	* If you want to delete a specific machine vagrant delete name of the machine
	* You can also take snapshot of your VMs using vagrant snapshot commands

> *"Note: All machines have to be able to communicate to each other."*

The deploy machine has to be able to communicate by SSH with the others machines.


# Setup Agorakube

Now that all your nodes are running, you will be able to setup Agorakube.

Connect to you "deploy" node and then run the following command:

```bash <(curl -s https://raw.githubusercontent.com/ilkilab/Agorakube/master/setup-deploy.sh)```

This command will install Ansible and clone the repository on your current path.

The second one must be applied to all other machines

```
bash <(curl -s https://raw.githubusercontent.com/ilkilab/Agorakube/master/setup-hosts.sh)
```

This command will update the machine and install the latest version of Python (Ansible needs Python and SSH to work).


# Create a pair of SSH keys

Agorakube is using Ansible to deploy Kubernetes. Ansible is using an SSH connection to configure the other machines. For that you need the create SSH keys.

On your deploy machine use this command:

```
ssh-keygen
```

It will create a Pair of keys that you will use for you SSH connection


I suggest letting everything by default for this tutorial, by letting everything by default you will be able to copy and paste most of the code provided in this tutorial.

Once you have created your pair of keys, do not forget to set the public key (here id_rsa.pub) in the other machine in /home/youruser/.ssh/authorized_keys or use ssh-copy-id (the password for vagrant user is vagrant)

## Modify the hosts file

Now, you need to modify the hosts file of Agorakube. This s file is composed of 5 parts. The first one is the group deploy. In this group, you will declared you deploy machine to Ansible.
The second is for declaring the master machines, the third is for etcd, the fourth is for worker and the fifth is for declaring 1 master IP that can be public or local and the SSH connection settings.

Below the original file from the project. You have to modify it with your own specification.

```ini
[deploy]
deploy ansible_connection=local

[masters]
master  ansible_host=10.0.0.11

[etcd]
etcd  ansible_host=10.0.0.13

[workers]
master  ansible_host=10.0.0.11
worker  ansible_host=10.0.0.12

[all:vars]
advertise_ip_masters=10.0.0.11
ansible_ssh_extra_args='-o StrictHostKeyChecking=no'
ansible_user=vagrant
ansible_ssh_private_key_file=/home/vagrant/.ssh/id_rsa
```
> *"Note: When you declare a machine, you have to use the FQDN."*

# Configure Agorakube Settings

Agorakube is fully customizable. To customize it, modify *./group_vars/all.yaml** file.

You have all information about this file in the [documentation](../main/parameters.md).

You have below the file used for this tutorial:

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
etcd_release: v3.4.3
kubernetes_release: v1.17.3
delete_previous_k8s_install: False
delete_etcd_install: False
check_etcd_install: True

# IPs-CIDR Configurations
cluster_cidr: 10.33.0.0/16
service_cluster_ip_range: 10.32.0.0/24
kubernetes_service: 10.32.0.1
cluster_dns_ip: 10.32.0.10
service_node_port_range: 30000-32767
kube_proxy_mode: ipvs
kube_proxy_ipvs_algotithm: rr


# Custom features
runtime: containerd
network_cni_plugin: flannel
flannel_iface: eth1
ingress_controller: traefik
dns_server_soft: coredns
populate_etc_hosts: yes
k8s_dashboard: True
service_mesh: linkerd
linkerd_release: stable-2.6.0
install_helm: true
init_helm: true
install_kubeapps: false

# Calico
calico_mtu: 1440

# Security
encrypt_etcd_keys: 
  key1:
    secret: 1fJcKt6vBxMt+AkBanoaxFF2O6ytHIkETNgQWv4b/+Q=

# Data Directory
data_path: "/var/agorakube"
etcd_data_directory: "/var/lib/etcd"
#restoration_snapshot_file: /path/snopshot/file Located on {{ etcd_data_directory }}
```

# Deploy K8S with Agorakube

Now that your K8S cluster is defined and configured in ".hosts" and "./groug_vars/all.yaml" files you are ready to run the Agorakube installation.

Run the followinf command:
```
sudo ansible-playbook agorakube.yaml
```

The installation prosses can take a wile to complite, so just wait.

At the end of installation, you must see the following screen:

<p align="center"> <img src="../../images/completed_install.png" width="400" alt="Agorakube" title="Agorakube" />
</p>


> *Note: If some errors occures, juste run again the agorakube installation. Agorakube installation process is idempotent.*