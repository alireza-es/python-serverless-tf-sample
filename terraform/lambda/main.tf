resource "aws_lambda_function" "example_lambda" {
    function_name = "exampleLambdaFunction"
    handler       = "lambda_function_one.lambda_handler"
    runtime       = "python3.8"
    role          = aws_iam_role.lambda_exec_role.arn
    source_code_hash = filebase64sha256("${path.module}/../../lambda_package.zip")
    filename      = "${path.module}/../../lambda_package.zip"

    environment {
        variables = {
            EXAMPLE_VAR = "exampleValue"
        }
    }
}

resource "aws_iam_role" "lambda_exec_role" {
    name = "lambda_exec_role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Principal = {
                    Service = "lambda.amazonaws.com"
                }
                Effect = "Allow"
                Sid = ""
            },
        ]
    })
}