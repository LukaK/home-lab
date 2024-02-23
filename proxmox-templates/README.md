# proxmox templates

Using packer to create vm templates for home lab.

Requirements:
- packer
- open firewall port ( 8802 ) for reverse connection from vm

How to create a proxmox token:
1. proxmox -> data center -> permissions -> api tokens
2. add -> choose user -> deselect privilage separation
3. save token id and secret

#### Usage
```
# populate credentials.pkr.hcl

# validate the template
pushd ubuntu-server-focal
packer validate --var-file=../credentials.pkr.hcl ubuntu-server-focal.pkr.hcl

# build image
packer build --var-file=../credentials.pkr.hcl ubuntu-server-focal.pkr.hcl
popd
```

#### Shoutout
- [Christian Lempa](https://www.youtube.com/@christianlempa)
