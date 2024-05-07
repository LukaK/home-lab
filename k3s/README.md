# kubernetes

Steps:
- make sure template is created with proxmox/packer
- provision the infrastructure with terraform
- install and configure k3s with ansible
- download kubeconfig from one of the master nodes
- setup ingress controller
- setup certificate manager
- setup nfs provisioner


### Ansible

Ansible k3s configuration.

Requirements:
- ansible

#### Usage

Follow instruction in the readme.

### Terraform

Terraform deployment scripts.

Requirements:
- terraform

How to create a proxmox token:
1. proxmox -> data center -> permissions -> api tokens
2. add -> choose user -> deselect privilege separation
3. save token id and secret

#### Usage
```
# populate secrets.auto.tfvars

# install packer dependencies
terraform init
terraform plan
terraform apply

# resize disks manually for worker nodes

```

# synology-csi

## Synology configuration
