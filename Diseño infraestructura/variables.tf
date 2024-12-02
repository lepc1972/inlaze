# variables.tf

variable "my_ip" {
  description = "Your personal IP address in CIDR notation"
  type        = string
}

variable "db_instance_type" {
  description = "Database instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "multi_az" {
  description = "Whether to create a multi-AZ RDS instance"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "VPC ID where the RDS instance will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs for the RDS instance"
  type        = list(string)
}