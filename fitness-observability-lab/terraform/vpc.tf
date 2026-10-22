module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1" # WHY 5.8.1? Latest stable that works with provider 5.x
  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"
  azs             = local.azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true # WHY? Nodes in private subnets need to pull ECR images + internet
  single_nat_gateway   = false # WHY false for prod? true = single point of failure. false = one per AZ
  enable_dns_hostnames = true
  # WHY these tags? EKS auto-discovers subnets for LoadBalancers via these tags
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}