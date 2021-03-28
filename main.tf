# Define Variables
  variable "prov_username" {}
  variable "prov_password" {}
  variable "prov_endpoint" {}
  variable "prov_cluster_name" {}
  variable "prov_vmname_prefix" {}
  variable "prov_num" {}
  variable "prov_subnet_uuid" {}
  variable "prov_diskimage_uuid" {}
  variable "prov_vcpu" {}
  variable "prov_sock" {}
  variable "prov_mem" {}

# Provider
provider "nutanix" {
  username  = var.prov_username
  password  = var.prov_password
  endpoint  = var.prov_endpoint
  insecure  = true
  port      = 9440
}

data "nutanix_clusters" "clusters" {}
locals {
	prov_cluster = [
	for cluster in data.nutanix_clusters.clusters.entities :
        cluster if cluster.name == var.prov_cluster_name
	][0]
}

resource "nutanix_virtual_machine" "nutanix_virtual_machine"{
  # General Information
  count                = var.prov_num
  name                 = "${var.prov_vmname_prefix}${format("%03d",count.index+1)}"
  description          = "Provisioned by Terraform"
  num_vcpus_per_socket = var.prov_vcpu
  num_sockets          = var.prov_sock
  memory_size_mib      = var.prov_mem

  # Configure Cluster
  cluster_uuid = local.prov_cluster.metadata.uuid

  # Configure Network   
  nic_list {
    subnet_uuid = var.prov_subnet_uuid
  }

  # Configure Disk
  disk_list {
    data_source_reference = {
        kind = "image"
        uuid = var.prov_diskimage_uuid
      }
    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }
      device_type = "DISK"
    }
  }
}
