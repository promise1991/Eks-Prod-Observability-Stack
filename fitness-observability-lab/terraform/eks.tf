module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.32"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  enable_irsa     = true
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns            = { most_recent = true }
    kube-proxy         = { most_recent = true }
    vpc-cni            = { most_recent = true }
  }

  eks_managed_node_groups = {
    main = {
      name           = "${var.cluster_name}-ng"
      # WHY this list? All are free-tier eligible from your output
      # m7i-flex.large = 8GB RAM (best), c7i-flex.large = 4GB, t3.small = 2GB fallback
      instance_types = ["m7i-flex.large", "c7i-flex.large", "t3.small"]
      capacity_type  = "ON_DEMAND"
      min_size       = 2
      max_size       = 3
      desired_size   = 2
      update_config = {
        max_unavailable = 1
      }
    }
  }
}