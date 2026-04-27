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

# Download a single cloud image.
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
  }
}
