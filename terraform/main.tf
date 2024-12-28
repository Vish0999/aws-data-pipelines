provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "data_bucket" {
  bucket = "mybucket-123"
}

resource "aws_db_instance" "db_instance" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "mydatabase"
  username             = "admin"
  password             = "password123"
  skip_final_snapshot  = true
}



resource "aws_lambda_function" "data_pipeline" {
  function_name = "data-pipeline-function"
  image_uri     = aws_ecr_repository.repo.repository_url
  role          = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_glue_catalog_database" "db" {
  name = "glue_database"
}

resource "aws_glue_catalog_table" "table" {
  name          = "glue_table"
  database_name = aws_glue_catalog_database.db.name
  table_type    = "EXTERNAL_TABLE"
  storage_descriptor {
    location = "s3://${aws_s3_bucket.data_bucket.bucket}/"
  }
}
