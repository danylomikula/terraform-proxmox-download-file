resource "proxmox_download_file" "this" {
  for_each = var.files

  node_name               = coalesce(each.value.node_name, var.common_node_name)
  datastore_id            = coalesce(each.value.datastore_id, var.common_datastore_id)
  content_type            = each.value.content_type
  url                     = each.value.url
  file_name               = each.value.file_name
  checksum                = each.value.checksum
  checksum_algorithm      = each.value.checksum != null ? each.value.checksum_algorithm : null
  decompression_algorithm = each.value.decompression_algorithm
  upload_timeout          = each.value.upload_timeout
  overwrite               = each.value.overwrite
  overwrite_unmanaged     = each.value.overwrite_unmanaged
  verify                  = each.value.verify
}

resource "proxmox_oci_image" "this" {
  for_each = var.oci_images

  node_name           = coalesce(each.value.node_name, var.common_node_name)
  datastore_id        = coalesce(each.value.datastore_id, var.common_datastore_id)
  reference           = each.value.reference
  file_name           = each.value.file_name
  overwrite           = each.value.overwrite
  overwrite_unmanaged = each.value.overwrite_unmanaged
  upload_timeout      = each.value.upload_timeout
}
