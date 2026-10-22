# Why data source for AZs? Don't hardcode azs, AWS may not have c in your region
data "aws_availability_zones" "available" {
  state = "available"
}
locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}