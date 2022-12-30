#------------------------------------------------------------------------------------------
# Action variables
#------------------------------------------------------------------------------------------

variable "create_resource_group" {
  description = "Action for creation or not of the resource group"
  type        = bool
  default     = false
}

#------------------------------------------------------------------------------------------
# Default variables
#------------------------------------------------------------------------------------------

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "location_name" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource. Use the map of {tag = value} format."
  type        = map(string)
  default     = {}
}

#------------------------------------------------------------------------------------------
# Recovery Services Vault variables
#------------------------------------------------------------------------------------------

variable "name" {
  description = "(Required) Specifies the name of the Recovery Services Vault. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "sku" {
  description = "(Required) Sets the vault's SKU. Possible values include: Standard, RS0."
  type        = string
  default     = null
}

variable "soft_delete_enabled" {
  description = "(Optional) Is soft delete enable for this Vault? Defaults to true."
  type        = bool
  default     = true
}

variable "storage_mode" {
  description = "(Optional) Sets the vault's storage mode. Possible values include: GeoRedundant, LocallyRedundant, ZoneRedundant."
  type        = string
  default     = null
}

variable "cross_region_restore_enabled" {
  description = "(Optional) Is cross region restore enabled for this Vault? Only can be true is the storage mode is GeoRedundant."
  type        = bool
  default     = null
}

#------------------------------------------------------------------------------------------
# Policy variables
#------------------------------------------------------------------------------------------

variable "backup_policy" {
  description = "A list of network interface IDs to attach to the VM."
  type = map(object({
    timezone      = optional(string)
    time          = string
    frequency     = string
    policy_type   = optional(string)
    instant_days  = optional(number)
    hour_interval = optional(number)
    hour_duration = optional(number)
    retention = optional(object({
      days            = optional(number)
      weeks           = optional(number)
      weeks_days      = optional(list(string))
      months          = optional(number)
      months_weekdays = optional(list(string))
      months_weeks    = optional(list(string))
      years           = optional(number)
      years_weekdays  = optional(list(string))
      years_weeks     = optional(list(string))
      years_months    = optional(list(string))
    }))
  }))
}

#------------------------------------------------------------------------------------------
# Protected Azure VM
#------------------------------------------------------------------------------------------

variable "protected_azvm" {
  description = "A list of virtual machine IDs to protect with the policy."
  type = map(object({
    policy = string
  }))
}
