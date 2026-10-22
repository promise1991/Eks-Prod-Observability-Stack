provider "aws" {
  region = "us-east-1" # WHY us-east-1? You used it before, close to Lagos for low latency, same as your previous cluster
}
resource "aws_ecr_repository" "fitness" {
  name                 = "fitness-app"
  image_tag_mutability = "MUTABLE" # WHY MUTABLE for lab? Allows overwriting v1.0.0 tag during iteration. Prod would be IMMUTABLE to prevent accidental overwrite
  force_delete         = true      # WHY? Allows terraform destroy even if images exist, for lab cleanup
  image_scanning_configuration {
    scan_on_push = true # WHY? Scans for CVEs on push, prod best practice, shows in interview you think about security
  }
}
output "ecr_url" {
  value = aws_ecr_repository.fitness.repository_url # WHY output? So Helm can use it without hardcoding account ID
}