module "backup_config" {
  source                = "../../terraform-azurerm-azure_backup"
  create_resource_group = true
  resource_group_name   = "test-rg"
  location_name         = "eastus"
  name                  = "recovery-vault-test"
  sku_name              = "Standard"

  tags = {
    "test" = "test"
  }
}
