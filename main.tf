terraform {
  required_version = ">= 0.11"

  backend "azurerm" {}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {}

# Generate random text for a unique log analytics workspace
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = "${var.aks_resource_group_name}"
  }

  byte_length = 8
}

module "vnet" {
  source = "./vnet"

  vnet_name           = "${var.vnet_name}"
  resource_group_name = "${var.vnet_resource_group_name}"
  location            = "${var.vnet_location}"
  address_space       = "${var.address_space}"
  subnet_prefixes     = "${var.subnet_prefixes}"
  subnet_names        = "${var.subnet_names}"
  tags                = "${var.tags}"
}

module "aks" {
  source = "./aks"

  client_id                        = "${var.client_id}"
  client_secret                    = "${var.client_secret}"
  client_app_id                    = "${var.client_app_id}"
  server_app_id                    = "${var.server_app_id}"
  server_app_secret                = "${var.server_app_secret}"
  agent_count                      = "${var.agent_count}"
  kubernetes_version               = "${var.kubernetes_version}"
  ssh_public_key                   = "${var.ssh_public_key}"
  dns_prefix                       = "${var.dns_prefix}"
  cluster_name                     = "${var.cluster_name}"
  resource_group_name              = "${var.aks_resource_group_name}"
  location                         = "${var.aks_location}"
  agentpool_subnet_id              = "${module.vnet.vnet_subnets[0]}"
  network_plugin                   = "${var.network_plugin}"
  dns_service_ip                   = "${var.dns_service_ip}"
  docker_bridge_cidr               = "${var.docker_bridge_cidr}"
  service_cidr                     = "${var.service_cidr}"
  log_analytics_workspace_name     = "${var.log_analytics_workspace_name}${random_id.randomId.hex}"
  log_analytics_workspace_location = "${var.log_analytics_workspace_location}"
  log_analytics_workspace_sku      = "${var.log_analytics_workspace_sku}"
  tags                             = "${var.tags}"
}
