# スケジュール定義
resource "aws_cloudwatch_event_rule" "event_rule" {

  name                = var.name
  schedule_expression = var.schedule

}
# スケジュール適応対象定義
resource "aws_cloudwatch_event_target" "event_target" {

  rule = aws_cloudwatch_event_rule.event_rule.name
  arn  = var.lambda_arn

}
