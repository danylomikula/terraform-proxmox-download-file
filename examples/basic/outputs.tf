output "file_ids" {
  description = "Map of file keys to their Proxmox file IDs."
  value       = module.images.file_ids
}

output "files" {
  description = "Map of all downloaded file resources with complete attributes."
  value       = module.images.files
}
