# apply時に出力
output "lambda_role_arn" {

  value       = aws_iam_role.lambda_line_counter_role.arn
  description = "The ID of lambda role what we regist"

}
