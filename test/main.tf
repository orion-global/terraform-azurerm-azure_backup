module "backup_config" {
  source                = "../../terraform-azurerm-azure_backup"
  create_resource_group = true
  resource_group_name   = "test-rg"
  location_name         = "eastus"
  name                  = "recovery-vault-test"
  sku                   = "Standard"
  policy_type           = "V2"
  instant_days          = 27
  backup_policy = {
    "test" = {
      time      = "23:00"
      frequency = "Daily"
      retention = {
        days            = 30
        weeks           = 2
        weeks_days      = ["Sunday", "Wednesday", "Friday", "Saturday"]
        months          = 2
        months_weekdays = ["Sunday", "Wednesday"]
        months_weeks    = ["First", "Last"]
        years           = 77
        years_weekdays  = ["Sunday"]
        years_weeks     = ["Last"]
        years_months    = ["January"]
      }
    }
  }

  tags = {
    "test" = "test"
  }
}
