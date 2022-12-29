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
