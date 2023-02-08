# Módulo para la creación de Recovery Service Vault en Azure
Este módulo crea una Recovery Services Vault en Azure, los recursos son:
* [Recovery Services Vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault)
* [Backup Policy en Azure VM](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm)
* [Protected Azure VM](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm)

Aquí está la lista de parámetros totales para su referencia:
* https://github.com/hashicorp/terraform-provider-azurerm/blob/main/website/docs/r/recovery_services_vault.html.markdown
* https://github.com/hashicorp/terraform-provider-azurerm/blob/main/website/docs/r/backup_policy_vm.html.markdown
* https://github.com/hashicorp/terraform-provider-azurerm/blob/main/website/docs/r/backup_protected_vm.html.markdown

---
**NOTA**: Módulo aún en desarrollo, se recomienda no emplearlo en entornos de producción.

---

## Usage

```hcl
module "backup_config" {
  source                       = "../../terraform-azurerm-azure_backup"
  create_resource_group        = true
  resource_group_name          = "test-rg"
  location_name                = "eastus"
  name                         = "recovery-vault-test"
  sku                          = "Standard"
  storage_mode                 = "LocallyRedundant"
  cross_region_restore_enabled = true
  backup_policy = {
    "test" = {
      time          = "23:00"
      frequency     = "Hourly"
      instant_days  = 27
      hour_interval = 4
      hour_duration = 4
      policy_type   = "V2"
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
    "test2" = {
      time         = "23:00"
      frequency    = "Daily"
      instant_days = 3
      policy_type  = "V1"
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

  protected_azvm = {
    "/subscriptions/7XXdXX9d-XXXX-XXXX-XXXX-787XX8XXf4XX/resourceGroups/RXXXXXXXX/providers/Microsoft.Compute/virtualMachines/XXXXX" = "test"
  }


  tags = {
    "test" = "test"
  }
}


```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.23 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.23 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_policy_vm.backup_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm) | resource |
| [azurerm_backup_protected_vm.protected_azvm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm) | resource |
| [azurerm_recovery_services_vault.recovery_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_policy"></a> [backup\_policy](#input\_backup\_policy) | A list of network interface IDs to attach to the VM. | <pre>map(object({<br>    timezone      = optional(string)<br>    time          = string<br>    frequency     = string<br>    policy_type   = optional(string)<br>    instant_days  = optional(number)<br>    hour_interval = optional(number)<br>    hour_duration = optional(number)<br>    retention = optional(object({<br>      days            = optional(number)<br>      weeks           = optional(number)<br>      weeks_days      = optional(list(string))<br>      months          = optional(number)<br>      months_weekdays = optional(list(string))<br>      months_weeks    = optional(list(string))<br>      years           = optional(number)<br>      years_weekdays  = optional(list(string))<br>      years_weeks     = optional(list(string))<br>      years_months    = optional(list(string))<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Action for creation or not of the resource group | `bool` | `false` | no |
| <a name="input_cross_region_restore_enabled"></a> [cross\_region\_restore\_enabled](#input\_cross\_region\_restore\_enabled) | (Optional) Is cross region restore enabled for this Vault? Only can be true is the storage mode is GeoRedundant. | `bool` | `null` | no |
| <a name="input_location_name"></a> [location\_name](#input\_location\_name) | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Recovery Services Vault. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_protected_azvm"></a> [protected\_azvm](#input\_protected\_azvm) | A list of virtual machine IDs to protect with the policy. | `map(any)` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) Sets the vault's SKU. Possible values include: Standard, RS0. | `string` | `null` | no |
| <a name="input_soft_delete_enabled"></a> [soft\_delete\_enabled](#input\_soft\_delete\_enabled) | (Optional) Is soft delete enable for this Vault? Defaults to true. | `bool` | `true` | no |
| <a name="input_storage_mode"></a> [storage\_mode](#input\_storage\_mode) | (Optional) Sets the vault's storage mode. Possible values include: GeoRedundant, LocallyRedundant, ZoneRedundant. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. Use the map of {tag = value} format. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## License

MIT Licensed. See [LICENSE](https://github.com/orion-global/terraform-module-template/tree/prod/LICENSE) for full details.