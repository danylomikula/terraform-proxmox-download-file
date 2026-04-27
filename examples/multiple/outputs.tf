output "file_ids" {
  description = "Map of file keys to their Proxmox file IDs."
  value       = module.images.file_ids
}

output "files_by_content_type" {
  description = "Map of content types to lists of file IDs."
  value       = module.images.files_by_content_type
}

output "files_by_node" {
  description = "Map of node names to lists of file IDs downloaded to that node."
  value       = module.images.files_by_node
}
