resource "azurerm_policy_definition" "allowed_app_service_skus" {
  name         = var.policy_definition_name
  policy_type  = "Custom"
  mode         = "All"
  display_name = var.policy_display_name
  description  = var.policy_description
  management_group_id = var.management_group_id

  metadata = jsonencode({
    version = "1.0.0"
    category = "App Service"
  })

  parameters = jsonencode({
    listOfAllowedSKUs = {
      type = "Array"
      metadata = {
        description  = var.skus_parameter_description
        displayName  = var.skus_parameter_display_name
        allowedValues = var.allowed_skus
      }
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type"
          equals = "Microsoft.Web/serverfarms"
        },
        {
          not = {
            field = "Microsoft.Web/serverfarms/sku.name"
            in    = "[parameters('listOfAllowedSKUs')]"
          }
        }
      ]
    }
    then = {
      effect = "Deny"
    }
  })
}


# place this in your module's main.tf
# resource "azurerm_subscription_policy_assignment" "allowed_app_service_skus" {
#   name                 = var.policy_assignment_name
#   policy_definition_id = azurerm_policy_definition.allowed_app_service_skus.id
#   subscription_id      = var.subscription_id
#   parameters = jsonencode({
#     listOfAllowedSKUs = {
#       value = var.allowed_skus
#     }
#   })
# }
# place this in your config file
# module "allowed_app_services_plan_skus" {
#   source = "./terraform-azurerm-appservice-sku-policy"
#   # management group id
#    management_group_id = "/providers/Microsoft.Management/managementGroups/YOUR_MANAGEMENT_GROUP_ID_HERE"
# }
