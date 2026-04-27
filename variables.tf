variable "files" {
  description = "Map of file download configurations keyed by a friendly name."
  type = map(object({
    url                     = string
    node_name               = optional(string)
    datastore_id            = optional(string)
    content_type            = optional(string, "iso")
    file_name               = optional(string)
    checksum                = optional(string)
    checksum_algorithm      = optional(string, "sha256")
    decompression_algorithm = optional(string)
    upload_timeout          = optional(number, 600)
    overwrite               = optional(bool, true)
    overwrite_unmanaged     = optional(bool, false)
    verify                  = optional(bool, true)
  }))
  default = {}

  validation {
    condition = alltrue([
      for key, file in var.files :
      contains(["iso", "vztmpl", "import"], file.content_type)
    ])
    error_message = "content_type must be one of: iso, vztmpl, import."
  }

  validation {
    condition = alltrue([
      for key, file in var.files :
      file.checksum_algorithm == null || contains(["md5", "sha1", "sha224", "sha256", "sha384", "sha512"], file.checksum_algorithm)
    ])
    error_message = "checksum_algorithm must be one of: md5, sha1, sha224, sha256, sha384, sha512."
  }

  validation {
    condition = alltrue([
      for key, file in var.files :
      file.decompression_algorithm == null || contains(["gz", "lzo", "zst", "bz2"], file.decompression_algorithm)
    ])
    error_message = "decompression_algorithm must be one of: gz, lzo, zst, bz2."
  }
}

variable "oci_images" {
  description = "Map of OCI image pull configurations keyed by a friendly name."
  type = map(object({
    reference           = string
    node_name           = optional(string)
    datastore_id        = optional(string)
    file_name           = optional(string)
    overwrite           = optional(bool, true)
    overwrite_unmanaged = optional(bool)
    upload_timeout      = optional(number, 600)
  }))
  default = {}
}

variable "common_node_name" {
  description = "Default Proxmox node name for all file downloads."
  type        = string
  default     = "pve"
}

variable "common_datastore_id" {
  description = "Default datastore ID for all file downloads."
  type        = string
  default     = "local"
}
