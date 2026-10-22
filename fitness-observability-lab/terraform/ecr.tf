resource "aws_ecr_repository" "fitness" {
  name                 = "fitness-app"
  image_tag_mutability = "MUTABLE" # Set IMMUTABLE for real prod, MUTABLE for lab to allow re-push v1
  force_delete         = true # WHY for lab? Allows terraform destroy even if images exist
  image_scanning_configuration {
    scan_on_push = true
  }
}
resource "aws_ecr_lifecycle_policy" "fitness" {
  repository = aws_ecr_repository.fitness.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 10 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
      action = { type = "expire" }
    }]
  })
}