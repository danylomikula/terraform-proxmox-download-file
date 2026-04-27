# Multiple Example

## Purpose
This example downloads multiple files to Proxmox:
- Rocky Linux 10 cloud image
- Debian 12 cloud image
- VirtIO drivers ISO

## What It Creates
- Three `proxmox_download_file` resources
- Mixed content types: `import` and `iso`
- Outputs: `file_ids`, `files_by_content_type`, `files_by_node`

## Prerequisites
- Proxmox VE API access.
- Datastore supports the used content types:
  - `import` for cloud images
  - `iso` for installer/media files

## Usage
```bash
cd examples/multiple

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
