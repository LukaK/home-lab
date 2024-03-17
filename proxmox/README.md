# proxmox

## configuration

Requirements:
- ansible

## packer

Resources for creating cloud-init proxmox templates.

Requirements:
- packer
- open firewall ports 8000-9000 for reverse proxy from proxmox vm

How to create proxmox token:
1. proxmox -> data center -> permissions -> api tokens
2. add -> choose user -> deselect privilage separation
3. save token id and secret

Directory structure:
- `packer/credentials.template.pkrvars.hcl`: proxmox connection details
- `packer/ubuntu-server-focal/values.auto.pkrvars.hcl`: ubuntu focal configuration variables
- `packer/ubuntu-server-focal/`: ubuntu focal image packer resources

#### Usage
```
# create credentials.pkr.hcl and populate with proxmox credentials
cp packer/credentials.template.pkr.hcl packer/credentials.pkr.hcl && chmod 600 packer/credentials.pkr.hcl
vim packer/credentials.pkr.hcl

# configure image
vim packer/ubuntu-server-focal/values.auto.pkrvars.hcl

# personalize user data, ssh keys
vim /packer/ubuntu-server-focal/http/user-data

# validate packer files
make pkr_validate

# build packer images
make pkr_build
```

#### Resources
- [Christian Lempa](https://www.youtube.com/@christianlempa)
