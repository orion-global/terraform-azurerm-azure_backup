#------------------------------------------------------------------------------------------
# Local Variables
#------------------------------------------------------------------------------------------

locals {

}

#------------------------------------------------------------------------------------------
# Resource Group
#------------------------------------------------------------------------------------------

resource "azurerm_resource_group" "resource_group" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location_name
  tags     = var.tags
}

data "azurerm_resource_group" "resource_group" {
  count = var.create_resource_group ? 0 : 1
  name  = var.resource_group_name
}

#------------------------------------------------------------------------------------------
# Recovery Services Vault
#------------------------------------------------------------------------------------------

resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = var.name
  location            = var.location_name
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  soft_delete_enabled = var.soft_delete_enabled
  tags                = var.tags

  # identity	                    (Optional) Anidentityblock as defined below.	
  #     An identity block supports the following:
  #     type - (Required) Specifies the type of Managed Service Identity that should be configured on this Recovery Services Vault. The only possible value is SystemAssigned.
  # storage_mode_type	            (Optional) The storage type of the Recovery Services Vault. Possible values areGeoRedundant,LocallyRedundantandZoneRedundant. Defaults toGeoRedundant.	
  # cross_region_restore_enabled	(Optional) Is cross region restore enabled for this Vault? Only can betrue, whenstorage_mode_typeisGeoRedundant. Defaults tofalse.	
  # encryption block supports the following:
  #     key_id - (Required) The Key Vault key id used to encrypt this vault. Key managed by Vault Managed Hardware Security Module is also supported.
  #     infrastructure_encryption_enabled - (Required) Enabling/Disabling the Double Encryption state.
  #     use_system_assigned_identity - (Optional) Indicate that system assigned identity should be used or not. At this time the only possible value is true. Defaults to true.

  depends_on = [
    azurerm_resource_group.resource_group,
    data.azurerm_resource_group.resource_group
  ]
}

resource "azurerm_backup_policy_vm" "backup_policy" {
  for_each            = var.backup_policy
  name                = each.key
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.recovery_vault.name
  timezone            = each.value.timezone
  policy_type         = each.value.policy_type

  # instant_restore_retention_days - (Optional) Specifies the instant restore retention range in days. Possible values are between 1 and 5 when policy_type is V1, and 1 to 30 when policy_type is V2.

  # The backup block supports:
  #   ~> NOTE: hour_duration must be multiplier of hour_interval
  #   hour_duration - (Optional) Duration of the backup window in hours. Possible values are between 4 and 24 This is used when frequency is Hourly.
  #   hour_interval - (Optional) Interval in hour at which backup is triggered. Possible values are 4, 6, 8 and 12. This is used when frequency is Hourly.
  #   weekdays - (Optional) The days of the week to perform backups on. Must be one of Sunday, Monday, Tuesday, Wednesday, Thursday, Friday or Saturday. This is used when frequency is Weekly.

  backup {
    frequency = each.value.frequency
    time      = each.value.time
  }

  dynamic "retention_daily" {
    for_each = each.value.frequency == "Daily" || each.value.retention.days != null ? [""] : []
    content {
      count = each.value.retention.days
    }
  }

  dynamic "retention_weekly" {
    for_each = each.value.frequency == "Weekly" || each.value.retention.weeks != null ? [""] : []
    content {
      count    = each.value.retention.weeks
      weekdays = each.value.retention.weeks_days
    }
  }

  dynamic "retention_monthly" {
    for_each = each.value.retention.months != null ? [""] : []
    content {
      count    = each.value.retention.months
      weekdays = each.value.retention.months_weekdays
      weeks    = each.value.retention.months_weeks
    }
  }

  dynamic "retention_yearly" {
    for_each = each.value.retention.years != null ? [""] : []
    content {
      count    = each.value.retention.years
      weekdays = each.value.retention.years_weekdays
      weeks    = each.value.retention.years_weeks
      months   = each.value.retention.years_months
    }
  }

  depends_on = [
    azurerm_recovery_services_vault.recovery_vault
  ]
}
