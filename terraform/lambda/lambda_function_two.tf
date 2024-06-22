resource "aws_lambda_function" "lambda_function_two" {
  filename         = var.file_path
  function_name    = var.function_name
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = var.handler
  runtime          = var.runtime
  source_code_hash = filebase64sha256(var.file_path)
  description      = var.description

  environment {
    variables = {
      ENV = "prod"
    }
  }
}
