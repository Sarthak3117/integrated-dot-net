provider "azurerm" {
  features {}
   subscription_id = "054f2ec0-512e-4743-b678-f72b4ac7435f"
}

resource "azurerm_resource_group" "rgas" {
  name     = resource17
  location = "West Europe"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "sherin_app_service_plan"
  location            = azurerm_resource_group.rgas.location
  resource_group_name = azurerm_resource_group.rgas.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "my-app_service" {
  name                = "integrated-dot-net17"
  location            = azurerm_resource_group.rgas.location
  resource_group_name = azurerm_resource_group.rgas.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
