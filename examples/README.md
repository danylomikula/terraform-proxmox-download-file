# Download File Module Examples

This directory contains runnable examples for the Proxmox download-file Terraform module.

## Examples

| Example | Description |
|---------|-------------|
| [basic](./basic) | Minimal single cloud image download (`content_type = "import"`). |
| [multiple](./multiple) | Download multiple cloud images plus an ISO and inspect grouped outputs. |

## Run an Example

```bash
cd <example-directory>
terraform init
terraform plan \
  -var="proxmox_endpoint=https://pve:8006" \
  -var="proxmox_api_token=root@pam!token=secret"
terraform apply \
  -var="proxmox_endpoint=https://pve:8006" \
  -var="proxmox_api_token=root@pam!token=secret"
```

## Clean Up

```bash
terraform destroy \
  -var="proxmox_endpoint=https://pve:8006" \
  -var="proxmox_api_token=root@pam!token=secret"
```

## Notes

- Read each example's local `README.md` for exact behavior and outputs.
- Use `content_type = "import"` for qcow2/img cloud images used by `disk.import_from`.
- Use `content_type = "iso"` for installer/media files mounted via `cdrom.file_id`.
