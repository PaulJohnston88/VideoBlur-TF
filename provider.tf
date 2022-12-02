terraform {
  backend "local" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.31.0"
    }
    azapi = {
      source = "azure/azapi"
    }
    godaddy = {
      source = "CruGlobal/godaddy"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "2587c9bd-2181-43d1-8bfa-20216d4a13e0"
}

provider "azurerm" {
  features {}
  alias = "Connectivity"
  subscription_id = var.ConnectivitySubscriptionID
}

provider "azapi" {
}