# Define Variables
  variable "username" {}
  variable "password" {}
  variable "endpoint" {}
  variable "vmname_prefix" {}
  variable "prov_num" {}
  variable "prov_cluster_uuid" {}
  variable "prov_subnet_uuid" {}
  variable "prov_diskimage_uuid" {}
  variable "prov_vcpu" {}
  variable "prov_sock" {}
  variable "prov_mem" {}

# Provider
provider "nutanix" {
  username  = var.username
  password  = var.password
  endpoint  = var.endpoint
  insecure  = true
  port      = 9440
}

data "nutanix_clusters" "clusters" {
}

resource "nutanix_virtual_machine" "nutanix_virtual_machine"{
  # General Information
  count                = var.prov_num
  name                 = "${var.vmname_prefix}${format("%03d",count.index+1)}"
  description          = "Provisioned by Terraform"
  num_vcpus_per_socket = var.prov_vcpu
  num_sockets          = var.prov_sock
  memory_size_mib      = var.prov_mem

  # クラスターの指定
  cluster_uuid = var.prov_cluster_uuid
  
  # ネットワークの設定
  nic_list {
    subnet_uuid = var.prov_subnet_uuid
  }

  # ディスクの設定
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
