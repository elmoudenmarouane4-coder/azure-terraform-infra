mock_provider "azurerm" {}

mock_provider "random" {
  mock_resource "random_id" {
    defaults = {
      hex = "1a2b3c4d"
    }
  }
}

run "storage_baseline" {
  command = apply

  assert {
    condition     = output.resource_group_name == "cloudportfolio-rg"
    error_message = "Unexpected resource group name."
  }

  assert {
    condition     = output.storage_account_name == "cloudportfolio1a2b3c4d"
    error_message = "The storage account name should include a random suffix."
  }

  assert {
    condition     = azurerm_storage_account.demo.https_traffic_only_enabled && azurerm_storage_account.demo.min_tls_version == "TLS1_2"
    error_message = "Enable HTTPS-only access and require TLS 1.2 or later."
  }

  assert {
    condition     = azurerm_storage_account.demo.allow_nested_items_to_be_public == false
    error_message = "Anonymous public access to blobs must be disabled."
  }
}
