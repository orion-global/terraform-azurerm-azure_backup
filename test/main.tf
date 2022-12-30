module "backup_config" {
  source                = "../../terraform-azurerm-azure_backup"
  create_resource_group = true
  resource_group_name   = "test-rg"
  location_name         = "eastus"
  name                  = "recovery-vault-test"
  sku                   = "Standard"

  backup_policy = {
    "test" = {
      time      = "23:00"
      frequency = "Daily"
      retention_dayli = {
        days = 30
      }
    }
  }

  tags = {
    "test" = "test"
  }
}
