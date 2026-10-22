variable "aws_region" {
  description = "Why variable? So you don't hardcode region in 10 places"
  type        = string
  default     = "eu-west-1"
}
variable "environment" {
  type    = string
  default = "prod"
}
variable "cluster_name" {
  type    = string
  default = "fitness-prod"
}