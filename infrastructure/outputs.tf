output "cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS cluster name."
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "EKS API endpoint."
}

output "oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
  description = "OIDC provider ARN used for IRSA."
}

output "external_dns_irsa_role_arn" {
  value       = module.external_dns_irsa.role_arn
  description = "IRSA role ARN for ExternalDNS service account."
}

output "alb_controller_irsa_role_arn" {
  value       = module.alb_controller_irsa.role_arn
  description = "IRSA role ARN for AWS Load Balancer Controller service account."
}

output "efs_csi_irsa_role_arn" {
  value       = module.efs_csi_irsa.role_arn
  description = "IRSA role ARN for EFS CSI controller service account."
}

output "efs_file_system_id" {
  value       = module.efs.file_system_id
  description = "EFS filesystem ID for WordPress persistent storage."
}
