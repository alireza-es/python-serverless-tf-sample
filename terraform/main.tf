module "lambda" {
  source = "./lambda"
}
terraform {
  backend "s3" {
    region = "ca-central-1"
    key    = "myterraform.tfstate"
  }
}
