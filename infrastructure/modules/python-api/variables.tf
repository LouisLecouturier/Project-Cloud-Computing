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
  type        = string
}
variable "pg_port" {
  description = "PostgreSQL port"
  default     = 5432
  type        = number
}

variable "pg_database" {
  description = "PostgreSQL database name"
  default     = "postgres"
  type        = string
}

variable "vnet_id" {
  description = "ID of the virtual network"
  type        = string
}

variable "app_subnet_id" {
  description = "ID of the app subnet"
  type        = string
}
