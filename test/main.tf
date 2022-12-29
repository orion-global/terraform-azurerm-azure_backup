module "backup_config" {
  source                 = "../../terraform-azurerm-azure_backup"
  create_resource_group  = true
  resource_group_name    = "test-rg"
  location_name          = "eastus"
  name = "rsv_test"

  tags = {
    "test" = "test"
  }
}