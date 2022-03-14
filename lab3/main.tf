terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99.0"
    }
  }
  required_version = "~> 1.1.7"
}

provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg" {
  name     = "trrg"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "rg" {
  name                = "example-aks2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "traks00"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_d2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Environment = "Production"
  }
}
output "client_certificate" {
  value = azurerm_kubernetes_cluster.rg.kube_config.0.client_certificate
}
output "kube_config" {
  value     = azurerm_kubernetes_cluster.rg.kube_config_raw
  sensitive = true
}