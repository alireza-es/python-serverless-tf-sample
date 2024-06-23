module "lambda_function_one" {
  source       = "./lambda_function"
  function_name = "lambda_function_one"
  handler       = "lambda_function_one.lambda_handler"
  runtime       = "python3.9"
  filename      = "path/to/lambda_function_one.zip"
  environment_variables = {
    VAR_NAME = "value"
  }
}

module "lambda_function_two" {
  source       = "./lambda_function"
  function_name = "lambda_function_two"
  handler       = "lambda_function_two.lambda_handler"
  runtime       = "python3.9"
  filename      = "path/to/lambda_function_two.zip"
  environment_variables = {
    VAR_NAME = "value"
  }
}

module "api_gateway" {
  source  = "./api_gateway"
  lambda_function_arns = {
    lambda_function_one = module.lambda_function_one.lambda_function_arn
    lambda_function_two = module.lambda_function_two.lambda_function_arn
  }
}
