# Basic Example

## Purpose
This example downloads one Rocky Linux 10 cloud image to Proxmox storage.

## What It Creates
- One `proxmox_download_file` resource
- Content type: `import`
- File name: `rocky-10-generic-cloud-base.qcow2`
- Outputs: `file_ids`, `files`

## Prerequisites
- Proxmox VE API access.
- Target datastore exists and supports `import` content type.

## Usage
```bash
cd examples/basic

terraform init
terraform plan \
  -var="proxmox_endpoint=https://pve:8006" \
  -var="proxmox_api_token=root@pam!token=secret"

terraform apply \
  -var="proxmox_endpoint=https://pve:8006" \
  -var="proxmox_api_token=root@pam!token=secret"
```

## Cleanup
```bash
terraform destroy \
  -var="proxmox_endpoint=https://pve:8006" \
  -var="proxmox_api_token=root@pam!token=secret"
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
