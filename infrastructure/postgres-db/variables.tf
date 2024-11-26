variable "pg_account_name" {
  type        = string
  default     = "pgaccount"
  description = "Account used for the db."
}

variable "rg_name" {
  type        = string
  default     = null
  description = "Name of the ressource group."
}

variable "location" {
  type        = string
  description = "The location/region where the resource group is created."
}

variable "pg_admin_username" {
  type        = string
  description = "Username for the PostgreSQL admin"
}

variable "pg_admin_password" {
  type        = string
  description = "Password for the PostgreSQL admin"
  sensitive   = true
}