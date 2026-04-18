module "network" {
  source = "./modules/network"

  cluster_name = var.cluster_name
  vpc_cidr     = var.vpc_cidr
  azs          = local.azs
  tags         = local.common_tags
}

module "eks" {
  source = "./modules/eks"

  cluster_name        = var.cluster_name
  cluster_version     = var.cluster_version
  private_subnet_ids  = module.network.private_subnet_ids
  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  admin_iam_arns      = var.admin_iam_arns
  tags                = local.common_tags
}

module "efs" {
  source = "./modules/efs"

  cluster_name        = var.cluster_name
  vpc_id              = module.network.vpc_id
  vpc_cidr            = var.vpc_cidr
  private_subnet_ids  = module.network.private_subnet_ids
  tags                = local.common_tags
}

module "external_dns_irsa" {
  source = "./modules/irsa-role"

  role_name             = "${var.cluster_name}-external-dns-irsa"
  oidc_provider_arn     = module.eks.oidc_provider_arn
  oidc_provider_url     = module.eks.oidc_provider_url
  namespace             = "kube-system"
  service_account_name  = "external-dns"
  inline_policy_json    = local.external_dns_policy_json
  managed_policy_arns   = []
  tags                  = local.common_tags
}

module "alb_controller_irsa" {
  source = "./modules/irsa-role"

  role_name             = "${var.cluster_name}-alb-controller-irsa"
  oidc_provider_arn     = module.eks.oidc_provider_arn
  oidc_provider_url     = module.eks.oidc_provider_url
  namespace             = "kube-system"
  service_account_name  = "aws-load-balancer-controller"
  inline_policy_json    = local.alb_controller_policy_json
  managed_policy_arns   = []
  tags                  = local.common_tags
}

module "efs_csi_irsa" {
  source = "./modules/irsa-role"

  role_name             = "${var.cluster_name}-efs-csi-irsa"
  oidc_provider_arn     = module.eks.oidc_provider_arn
  oidc_provider_url     = module.eks.oidc_provider_url
  namespace             = "kube-system"
  service_account_name  = "efs-csi-controller-sa"
  managed_policy_arns   = ["arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"]
  tags                  = local.common_tags
}


