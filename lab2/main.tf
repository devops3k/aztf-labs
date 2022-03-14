provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg1" {
    name = "labdemorg00"
    location = "eastus"
}

resource "azurerm_cosmosdb_account" "cosmosdbwa" {
    name = "cosmosdbwa"
    location = "eastus"
    resource_group_name = azurerm_resource_group.rg1.name
    offer_type = "Standard"
    kind = "GlobalDocumentDB"
    consistency_policy {
        consistency_level = "BoundedStaleness"
        max_interval_in_seconds = 10
        max_staleness_prefix = 200
    }

    geo_location {
        location = "eastus"
        failover_priority = 0
    }
}