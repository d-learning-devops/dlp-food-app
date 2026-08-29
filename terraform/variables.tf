variable "prefix" {
  type        = string
  default     = "zomatoclone"
  description = "Prefix for all resources"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure region"
}

variable "node_count" {
  type        = number
  default     = 2
  description = "Initial node pool count"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B2s"
  description = "VM SKU for the worker nodes"
}

variable "budget_amount" {
  type        = number
  default     = 120
  description = "Total monthly budget limit in USD"
}

variable "alert_email_addresses" {
  type        = list(string)
  default     = ["your-email@example.com"]
  description = "Email recipients for budget alert notifications"
}
