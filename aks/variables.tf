variable "client_id" {}
variable "client_secret" {}

variable "agent_count" {
    default = 3
}

variable "kubernetes_version" {
    default = "1.11.5"
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "aks-demo"
}

variable cluster_name {
    default = "aks-demo"
}

variable resource_group_name {
    default = "rg-aks"
}

variable location {
    default = "East US"
}

variable log_analytics_workspace_name {
    default = "AKSLogAnalyticsWorkspace"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "eastus"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = "map"

  default = {
    source = "terraform"
    environment = "demo"
    purpose = "aksdemo"
  }
}