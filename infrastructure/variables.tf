variable "rg_location" {
  type        = string
  default     = "francecentral"
  description = "Location of the resource group"
}


variable "pg_admin_username" {
  type        = string
  description = "Username for the PostgreSQL admin"
}

variable "pg_admin_password" {
  type        = string
  description = "Password for the PostgreSQL admin"
  sensitive = true
}
