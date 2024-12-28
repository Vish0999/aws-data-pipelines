# before run overall project or Main.tf file run Ecr.tf file locally to create ECR 
provider "aws" {
  region = "eu-north-1" 
}

# Create ECR Repository
resource "aws_ecr_repository" "data_pipeline_repo" {
  name                 = "data-pipeline-repo"
  image_tag_mutability = "MUTABLE" 
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Environment = "Dev"
    Project     = "DataPipeline"
  }
}


output "ecr_repository_url" {
  value = aws_ecr_repository.data_pipeline_repo.repository_url
  description = "URL of the ECR repository"
}
