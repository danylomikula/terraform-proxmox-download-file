terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.104.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_insecure
}

# Download multiple files to Proxmox storage.
module "images" {
  source = "../.."

  common_node_name    = "pve"
  common_datastore_id = "local"

  files = {
    rocky-10-cloud = {
      url          = "https://dl.rockylinux.org/pub/rocky/10/images/x86_64/Rocky-10-GenericCloud-Base.latest.x86_64.qcow2"
      content_type = "import"
      file_name    = "rocky-10-generic-cloud-base.qcow2"
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
