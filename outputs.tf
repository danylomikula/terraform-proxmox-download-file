output "files" {
  description = "Map of all downloaded file resources with complete attributes."
  value = {
    for key, file in proxmox_download_file.this : key => {
      id           = file.id
      node_name    = file.node_name
      datastore_id = file.datastore_id
      content_type = file.content_type
      file_name    = file.file_name
      url          = file.url
      size         = file.size
    }
  }
}

output "file_ids" {
  description = "Map of file keys to their resource IDs (for use as file_id/import_from in VM resources)."
  value = {
    for key, file in proxmox_download_file.this : key => file.id
  }
}

output "files_by_content_type" {
  description = "Map of content types to lists of file IDs."
  value = {
    for content_type in distinct([for file in values(proxmox_download_file.this) : file.content_type]) :
    content_type => [
      for file in values(proxmox_download_file.this) : file.id
      if file.content_type == content_type
    ]
  }
}

output "files_by_node" {
  description = "Map of node names to lists of file IDs downloaded to that node."
  value = {
    for node in distinct([for file in values(proxmox_download_file.this) : file.node_name]) :
    node => [
      for file in values(proxmox_download_file.this) : file.id
      if file.node_name == node
    ]
  }
}

# OCI images.
output "oci_images" {
  description = "Map of all pulled OCI image resources with complete attributes."
  value = {
    for key, image in proxmox_oci_image.this : key => {
      id           = image.id
      node_name    = image.node_name
      datastore_id = image.datastore_id
      reference    = image.reference
      file_name    = image.file_name
      size         = image.size
    }
  }
}

output "oci_image_ids" {
  description = "Map of OCI image keys to their resource IDs (for use as template_file_id in LXC resources)."
  value = {
    for key, image in proxmox_oci_image.this : key => image.id
  }
}
