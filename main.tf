# Define Variables
  variable "prov_username" {}
  variable "prov_password" {}
  variable "prov_endpoint" {}
  variable "prov_cluster_name" {}
  variable "prov_vmname_prefix" {}
  variable "prov_num" {}
  variable "prov_subnet_name" {}
  variable "prov_vcpu" {}
  variable "prov_sock" {}
  variable "prov_mem" {}
  variable "parent_uuid" {}
  variable "parent_name" {}

# Provider
provider "nutanix" {
  username  = var.prov_username
  password  = var.prov_password
  endpoint  = var.prov_endpoint
  insecure  = true
  port      = 9440
}

data "nutanix_cluster" "cluster" {
  name = var.prov_cluster_name
}

data "nutanix_subnet" "ahv_network" {
  subnet_name = var.prov_subnet_name
}

resource "nutanix_virtual_machine" "nutanix_virtual_machine"{
  # General Information
  count                = var.prov_num
  name                 = "${var.prov_vmname_prefix}${format("%03d",count.index+1)}"
  description          = "Provisioned by Terraform"
  parent_reference = {
    "kind" = "vm"
    "name" = var.parent_name
    "uuid" = var.parent_uuid
  }

  # Configure Cluster
  cluster_uuid = data.nutanix_cluster.cluster.metadata.uuid

  # Configure Network   
  nic_list {
    subnet_uuid = data.nutanix_subnet.ahv_network.metadata.uuid
  }
}
