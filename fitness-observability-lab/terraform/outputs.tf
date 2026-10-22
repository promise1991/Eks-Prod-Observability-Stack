output "cluster_name" {
  value = module.eks.cluster_name
}
output "ecr_url" {
  value = aws_ecr_repository.fitness.repository_url
  description = "Use this for docker push"
}
output "update_kubeconfig_command" {
  value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}
