provider "aws" {
  region = var.region
}

module "lambda_function_one" {
  source = "./lambda"
  function_name = "lambda_function_one"
  file_path = "${path.module}/../src/lambda_function_payload/lambda_function_one_payload.zip"
  handler = "lambda_function_one.lambda_handler"
  runtime = "python3.9"
  description = "Lambda function for endpoint one"
}

module "lambda_function_two" {
  source = "./lambda"
  function_name = "lambda_function_two"
  file_path = "${path.module}/../src/lambda_function_payload/lambda_function_two_payload.zip"
  handler = "lambda_function_two.lambda_handler"
  runtime = "python3.9"
  description = "Lambda function for endpoint two"
}

module "api_gateway" {
  source = "./api_gateway"
  api_name = "MyAPIGateway"
  description = "API Gateway for my Lambda functions"
  lambda_functions = {
    "lambda_function_one" = module.lambda_function_one.lambda_function_arn
    "lambda_function_two" = module.lambda_function_two.lambda_function_arn
  }
}
