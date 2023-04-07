locals {

  filepath = "teste.json"

  common_tags = {
    Service    = "Curso Terraform"
    Managed_By = "Terraform"
    Owner      = "Paulo Henrique Michelin"
    Enviroment = var.environment
  }
}