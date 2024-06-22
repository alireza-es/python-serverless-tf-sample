resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = var.description
}

resource "aws_api_gateway_resource" "resource_one" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "endpoint_one"
}

resource "aws_api_gateway_resource" "resource_two" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "endpoint_two"
}

resource "aws_api_gateway_method" "method_one" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_one.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "method_two" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_two.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_lambda_permission" "api_gw_one" {
  statement_id  = "AllowAPIGatewayInvokeOne"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_functions["lambda_function_one"]
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/GET/endpoint_one"
}

resource "aws_lambda_permission" "api_gw_two" {
  statement_id  = "AllowAPIGatewayInvokeTwo"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_functions["lambda_function_two"]
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/GET/endpoint_two"
}

resource "aws_api_gateway_integration" "integration_one" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource_one.id
  http_method             = aws_api_gateway_method.method_one.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_functions["lambda_function_one"]
}

resource "aws_api_gateway_integration" "integration_two" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource_two.id
  http_method             = aws_api_gateway_method.method_two.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_functions["lambda_function_two"]
}

output "api_gateway_url" {
  value = aws_api_gateway_deployment.api.invoke_url
}
