terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    # Fill these AFTER you create the bucket & table (one-time bootstrap)
    bucket         = "REPLACE_WITH_TF_STATE_BUCKET"
    key            = "aws-lakehouse-spark-platform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "REPLACE_WITH_TF_LOCK_TABLE"
    encrypt        = true
  }
}