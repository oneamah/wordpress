variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "node_instance_types" {
  type = list(string)
}

variable "node_desired_size" {
  type = number
}

variable "node_min_size" {
  type = number
}

variable "node_max_size" {
  type = number
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "admin_iam_arns" {
  description = "List of IAM user/role ARNs to grant cluster-admin access via EKS access entries."
  type        = list(string)
  default     = []
}
