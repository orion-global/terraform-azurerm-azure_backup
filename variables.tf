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

variable "backup_policy" {
  description = "A list of network interface IDs to attach to the VM."
  type = map(object({
    timezone    = optional(string)
    time        = string
    frequency   = string
    policy_type = optional(string)
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
