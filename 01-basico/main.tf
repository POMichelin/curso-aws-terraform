terraform {
  required_version = "1.4.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
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
  #acl    = "private" --> aws_s3_bucket_acl
  tags = local.common_tags
}

resource "aws_s3_bucket_acl" "this" {
  acl    = "private"
  bucket = aws_s3_bucket.this.id
}

resource "aws_s3_object" "file" {
  bucket = aws_s3_bucket.this.bucket
  key    = "teste/${local.filepath}"
  source = local.filepath
  etag   = filemd5(local.filepath)
  tags   = local.common_tags
  content_type = "application/json"
}

resource "aws_s3_object" "random_file" {
  bucket = aws_s3_bucket.this.bucket
  key    = "teste/${random_uuid.random.result}.json"
  source = local.filepath
  etag   = filemd5(local.filepath)
  tags   = local.common_tags
  content_type = "application/json"
}

#Terraform import --> Permite gerenciar com o terraform a infra de um recurso criado manualmente 