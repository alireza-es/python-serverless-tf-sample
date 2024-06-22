output "api_gateway_url" {
  description = "The URL of the API Gateway"
  value       = module.api_gateway.api_gateway_url
}

output "lambda_function_one_arn" {
  description = "ARN of the first Lambda function"
  value       = module.lambda_function_one.lambda_function_arn
}

output "lambda_function_two_arn" {
  description = "ARN of the second Lambda function"
  value       = module.lambda_function_two.lambda_function_arn
}
