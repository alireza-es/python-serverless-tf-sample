module "lambda" {
  source = "./lambda"
}
terraform {
  backend "s3" {
    region = var.aws_region
    key    = "myterraform.tfstate"
  }
}
