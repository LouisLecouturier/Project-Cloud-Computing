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
  description = "PostgreSQL admin username"
  type        = string
}

variable "pg_admin_password" {
  description = "PostgreSQL admin password"
  type        = string
}

variable "pg_host" {
  description = "PostgreSQL host"
  default     = "0.0.0.0"
  type        = string
}

variable "pg_database" {
  description = "PostgreSQL database name"
  default     = "postgres"
  type        = string
}
