terraform {
  required_version = "1.4.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_uuid" "random" {

}

resource "aws_s3_bucket" "this" {
  bucket = "my-tf-test-bucket-${random_uuid.random.result}"
  #acl    = "private"
  tags = {
    Name       = "My Test Bucket"
    Enviroment = "Test"
    Managed_By = "Terraform"
  }
}

resource "aws_s3_bucket_acl" "this" {
  acl    = "private"
  bucket = aws_s3_bucket.this.id
}