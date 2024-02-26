# infrastructure

Terraform deployment scripts.

Requirements:
- terraform

How to create a proxmox token:
1. proxmox -> data center -> permissions -> api tokens
2. add -> choose user -> deselect privilage separation
3. save token id and secret

#### Usage
```
# populate variables.auto.tfvars

# install packer dependencies
terraform init
terraform plan
terraform apply

```
