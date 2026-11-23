terraform {
  required_version = ">= 1.7, < 2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demo" {
  name     = "${var.project_name}-rg"
  location = var.location

  tags = local.tags
}

resource "random_id" "storage" {
  byte_length = 4
}

resource "azurerm_storage_account" "demo" {
  name                            = "${replace(var.project_name, "-", "")}${random_id.storage.hex}"
  resource_group_name             = azurerm_resource_group.demo.name
  location                        = azurerm_resource_group.demo.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false

  tags = local.tags
}

locals {
  tags = {
    project     = var.project_name
    environment = "dev"
  }
}
