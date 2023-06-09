terraform-azurerm-appservices_plan_sku
=============================================

This Terraform module, `terraform-azurerm-appservices_plan_sku`, deploys a policy to restrict the allowed App Service Plan SKUs to only those that can be used with App Service Environments (ASE).

Module was inspired by: https://www.azadvertizer.net/azpolicyadvertizer/app-service_allowed-appservicesplan-skus.html

More information about the module can be found here: 

Requirements
------------

-   Terraform v1.0.0 or later
-   Azurerm provider v3.0.0 or later

Usage
-----

Add the following code to your Terraform configuration, and replace the management_group_id with the ID of the management group to which the policy definition should be added:

`module "allowed_app_services_plan_skus" {
  source = "./terraform-azurerm-appservice-sku-policy"
  management_group_id = "/providers/Microsoft.Management/managementGroups/YOUR_MANAGEMENT_GROUP_ID_HERE"
}`

### Policy Assignment Example

The following code creates a policy assignment to enforce the policy definition created by the module:

`resource "azurerm_subscription_policy_assignment" "allowed_app_service_skus" {
  name                 = var.policy_assignment_name_app_service_skus
  policy_definition_id = var.policy_definition_id_app_service_skus
  subscription_id      = "/subscriptions/${var.appdev-subscription_id}"
  parameters = jsonencode({
    listOfAllowedSKUs = {
      value = var.allowed_app_service_skus
    }
  })
}`

main.tf
-------

This file contains the `azurerm_policy_definition` resource which creates the policy definition restricting the allowed App Service Plan SKUs.

variables.tf
------------

This file contains the variables required for the module, such as management_group_id, policy_definition_name, policy_display_name, policy_description, skus_parameter_description, skus_parameter_display_name, and allowed_skus.

You can customize the variables as needed, or use their default values.

Inputs
------

| Name | Description | Type | Default |
| --- | --- | --- | --- |
| management_group_id | The ID of the management group to which the policy definition should be added. | string | "/providers/Microsoft.Management/managementGroups/YOUR_MANAGEMENT_GROUP_ID_HEREE |
| policy_definition_name | The name of the policy definition. | string | "Allowed App Services Plan SKUs" |
| policy_display_name | The display name of the policy. | string | "Allowed App Services Plan SKUs" |
| policy_description | The description of the policy. | string | "Only allow SKUs that can be used with App Service Environments. This is to control the flow of network traffic to a compliant direction." |
| skus_parameter_description | The description for the listOfAllowedSKUs parameter. | string | "The list of SKUs that can be specified for App Services Plan." |
| skus_parameter_display_name | The display name for the listOfAllowedSKUs parameter. | string | "Allowed SKUs" |
| allowed_skus | The list of allowed App Service plan SKUs. | list(string) | ["I1", "I2", "I3", "I1v2", "I2v2", "I3v2"] |

Outputs
-------

No outputs are generated by this module.
