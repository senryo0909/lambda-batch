resource "aws_lambda_function" "line_api_notification_lambda" {

  filename         = data.archive_file.lambda_file.output_path
  function_name    = var.function_name
  role             = var.role_arn
  handler          = var.lambda_handler
  source_code_hash = data.archive_file.lambda_file.output_base64sha256
  runtime          = var.function_runtime
  memory_size      = var.memory_size
  timeout          = var.timeout

  tags = {
    product = var.name
  }

}

# CloudWatch Logs
resource "aws_cloudwatch_log_group" "log_group" {

  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_in_days

  tags = {
    Name        = var.name
    CreateOwner = var.tag_terraform_value
  }

}

# Archive Providerを使用してfileのzip化
data "archive_file" "lambda_file" {

  type        = var.archive_file_type
  source_dir  = var.lambda_source_dir
  output_path = var.deploy_upload_filename

}
