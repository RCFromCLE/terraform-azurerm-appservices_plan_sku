variable "management_group_id" {
  description = "The ID of the management group to which the policy definition should be added."
  type        = string
  default     = "/providers/Microsoft.Management/managementGroups/YOUR_MANAGEMENT_GROUP_ID_HERE"
}
variable "policy_definition_name" {
  description = "The name of the policy definition."
  type        = string
  default = "Allowed App Services Plan SKUs"
}
variable "policy_display_name" {
  description = "The display name of the policy."
  type        = string
  default = "Allowed App Services Plan SKUs"
}
variable "policy_description" {
  description = "The description of the policy."
  type        = string
  default = "Only allow SKUs that can be used with App Service Environments. This is to control the flow of network traffic to a compliant direction."
}
variable "skus_parameter_description" {
  description = "The description for the listOfAllowedSKUs parameter."
  type        = string
  default     = "The list of SKUs that can be specified for App Services Plan."
}
variable "skus_parameter_display_name" {
  description = "The display name for the listOfAllowedSKUs parameter."
  type        = string
  default     = "Allowed SKUs"
}
variable "allowed_skus" {
  description = "The list of allowed App Service plan SKUs. The below list restricts to only Isolated sku versions to be compliant with an ASE."
  type        = list(string)
  default     = ["I1", "I2", "I3", "I1v2", "I2v2", "I3v2"]
}