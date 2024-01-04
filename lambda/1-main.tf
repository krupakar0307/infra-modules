
provider "aws" {
    region = var.region
}






data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.filename
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "resource_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = var.function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.runtime


  environment {
    variables = var.environment_vars
  }
}