# iam module呼び出し
module "iam" {

  source = "./modules/iam"
  name   = var.app_name

}

# lambda module呼び出し

module "lambda" {

  source                = "./modules/lambda"
  name                  = var.app_name
  role_arn              = module.iam.lambda_role_arn #./modules/iam/main.tfで定義した独自role適用にoutput.tfを使用
  lambda_source_dir     = "../lambda_src"
  lambda_handler        = "index.handler"
  function_runtime      = "nodejs18.x"
  memory_size           = 128
  timeout               = 50
  log_retention_in_days = 14
  function_name         = "srcLineDistSlack"

}

module "cloudwatch_event" {

  source     = "./modules/cloudwatch"
  name       = var.app_name
  schedule   = "cron(0/10 * ? * MON-FRI *)"
  lambda_arn = module.lambda.arn

}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = module.cloudwatch_event.rule_arn
}
