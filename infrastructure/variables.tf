variable "rg_location" {
  type        = string
  default     = "northeurope"
  description = "Location of the resource group"
}

variable "pg_host" {
  type        = string
  default     = "0.0.0.0"
  description = "Host of the PostgreSQL database"
}

variable "pg_port" {
  type        = number
  default     = 5432
  description = "Port of the PostgreSQL database"
}

variable "pg_database" {
  type        = string
  default     = "postgres"
  description = "Name of the PostgreSQL database"
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
