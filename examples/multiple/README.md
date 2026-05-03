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
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.105.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_images"></a> [images](#module\_images) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_proxmox_api_token"></a> [proxmox\_api\_token](#input\_proxmox\_api\_token) | Proxmox API token. | `string` | n/a | yes |
| <a name="input_proxmox_endpoint"></a> [proxmox\_endpoint](#input\_proxmox\_endpoint) | Proxmox API endpoint URL. | `string` | n/a | yes |
| <a name="input_proxmox_insecure"></a> [proxmox\_insecure](#input\_proxmox\_insecure) | Skip TLS verification. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_file_ids"></a> [file\_ids](#output\_file\_ids) | Map of file keys to their Proxmox file IDs. |
| <a name="output_files_by_content_type"></a> [files\_by\_content\_type](#output\_files\_by\_content\_type) | Map of content types to lists of file IDs. |
| <a name="output_files_by_node"></a> [files\_by\_node](#output\_files\_by\_node) | Map of node names to lists of file IDs downloaded to that node. |
<!-- END_TF_DOCS -->
