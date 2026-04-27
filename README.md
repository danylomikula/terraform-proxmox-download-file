# Proxmox Download File Terraform Module

[![Release](https://img.shields.io/github/v/release/danylomikula/terraform-proxmox-download-file)](https://github.com/danylomikula/terraform-proxmox-download-file/releases)
[![Pre-Commit](https://github.com/danylomikula/terraform-proxmox-download-file/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/danylomikula/terraform-proxmox-download-file/actions/workflows/pre-commit.yml)
[![License](https://img.shields.io/github/license/danylomikula/terraform-proxmox-download-file)](https://github.com/danylomikula/terraform-proxmox-download-file/blob/main/LICENSE)

Terraform module for downloading ISO images, cloud images, container templates, and OCI images to Proxmox VE storage. Wraps the `proxmox_download_file` and `proxmox_oci_image` resources from the `bpg/proxmox` provider.

## Features

- Download multiple files in a single module call via map-based `for_each`
- Pull OCI/Docker images directly to a Proxmox datastore
- Checksum verification (`md5`, `sha1`, `sha224`, `sha256`, `sha384`, `sha512`)
- Automatic decompression (`gz`, `lzo`, `zst`, `bz2`)
- Shared `common_node_name` and `common_datastore_id` defaults merged with per-file overrides
- Rich outputs: file IDs grouped by content type and node, ready to feed into the VM/LXC modules

## Quick Start

```hcl
module "images" {
  source  = "danylomikula/download-file/proxmox"
  version = "~> 1.0"

  common_node_name    = "pve"
  common_datastore_id = "local"

  files = {
    rocky-10-cloud = {
      url          = "https://dl.rockylinux.org/pub/rocky/10/images/x86_64/Rocky-10-GenericCloud-Base.latest.x86_64.qcow2"
      content_type = "import"
      file_name    = "rocky-10-generic-cloud-base.qcow2"
    }
  }
}
```

## Examples

### Multiple Files with Checksums

```hcl
module "images" {
  source  = "danylomikula/download-file/proxmox"
  version = "~> 1.0"

  common_node_name    = "pve"
  common_datastore_id = "local"

  files = {
    rocky-10-cloud = {
      url                = "https://dl.rockylinux.org/pub/rocky/10/images/x86_64/Rocky-10-GenericCloud-Base.latest.x86_64.qcow2"
      content_type       = "import"
      file_name          = "rocky-10-generic-cloud-base.qcow2"
      checksum           = "abc123..."
      checksum_algorithm = "sha256"
    }

    debian-cloud = {
      url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
      content_type = "import"
      file_name    = "debian-12-generic-amd64.qcow2"
    }

    virtio-drivers = {
      url          = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso"
      content_type = "iso"
    }
  }
}
```

### Feed Outputs into the VM Module

```hcl
module "images" {
  source  = "danylomikula/download-file/proxmox"
  version = "~> 1.0"

  common_node_name    = "pve"
  common_datastore_id = "local"

  files = {
    ubuntu-cloud = {
      url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
      content_type = "import"
      file_name    = "ubuntu-24.04-cloudimg-amd64.qcow2"
    }
  }
}

module "vms" {
  source  = "danylomikula/vm/proxmox"
  version = "~> 1.0"

  common_node_name    = "pve"
  common_datastore_id = "local-lvm"

  vms = {
    web-01 = {
      disks = [{
        interface   = "scsi0"
        size        = 32
        import_from = module.images.file_ids["ubuntu-cloud"]
      }]

      network_devices = [{
        bridge = "vmbr0"
      }]
    }
  }
}
```

### OCI Images for LXC Application Containers

```hcl
module "images" {
  source  = "danylomikula/download-file/proxmox"
  version = "~> 1.0"

  common_node_name    = "pve"
  common_datastore_id = "local"

  oci_images = {
    nginx = {
      reference = "docker.io/library/nginx:latest"
      file_name = "nginx-latest.tar"
    }
  }
}
```

## Content Types

- `import` — qcow2/img cloud images consumed by VM `disk.import_from`.
- `iso` — installer/media files mounted via VM `cdrom.file_id`.
- `vztmpl` — LXC container templates referenced by `template_file_id`.

## Important Notes

- The Proxmox provider must be configured with API access; OCI image pulls and uploads of large images may also require SSH access to the target node.
- The target datastore must allow the requested `content_type`. Configure datastore content types in Proxmox under *Datacenter → Storage*.
- All `common_*` variables are merged with per-file values; per-file values always take precedence.
- `proxmox_oci_image` requires `bpg/proxmox >= 0.103.0`.

## Safe Image Cleanup

When a downloaded image is consumed by a VM (`disk.import_from`), removing the image while the VM still references it can fail or recreate the VM disk. Remove the image in two `terraform apply` runs:

1. Decouple the VM disk from the image module output:
   - Change `import_from` from `module.images.file_ids["rocky-cloud"]` to a literal file ID like `local:import/rocky-10-generic-cloud-base.qcow2`.
   - Run `terraform apply`.

2. Remove the image from the download module:
   - Delete the entry from the `files` map.
   - Run `terraform apply` again.

The VM disk is decoupled from the image after first boot — Terraform destroys only the `proxmox_download_file` resource.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Related Modules

| Module | Description | GitHub | Terraform Registry |
|--------|-------------|--------|--------------------|
| **terraform-proxmox-vm** | Manage Proxmox VE virtual machines with cloud-init, cloning, PCI/USB passthrough, and shared defaults | [GitHub](https://github.com/danylomikula/terraform-proxmox-vm) | [Registry](https://registry.terraform.io/modules/danylomikula/vm/proxmox) |

## Authors

Module managed by [Danylo Mikula](https://github.com/danylomikula).

## Contributing

Contributions are welcome! Please read the [Contributing Guide](.github/contributing.md) for details on the process and commit conventions.

## License

Apache 2.0 Licensed. See [LICENSE](LICENSE) for full details.
