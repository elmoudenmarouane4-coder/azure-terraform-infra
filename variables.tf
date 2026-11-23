variable "project_name" {
  description = "Lowercase project identifier used in Azure resource names."
  type        = string
  default     = "cloudportfolio"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,15}$", var.project_name)) && !endswith(var.project_name, "-")
    error_message = "Use 3 to 16 lowercase letters, digits or hyphens. Start with a letter and end with a letter or digit."
  }
}

variable "location" {
  description = "Azure region for this deployment."
  type        = string
  default     = "westeurope"
}
