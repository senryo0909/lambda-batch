# LambdaのIAMロールに適用するポリシー定義

# ベースポリシーを定義
resource "aws_iam_role" "lambda_line_counter_role" {

    name = "${var.name}-lambda-role"

    assume_role_policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "lambda.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }
    POLICY
}

# cloudwatchのログを出力させるpolicy
data "aws_iam_policy_document" "lambda_logging_policy" {

    statement {
        actions = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ]
        effect = "Allow"
        resources = ["*"]
    }
}

# 追加のpolicyを作成したロールにattach
resource "aws_iam_role_policy" "logs_from_lambda_to_cloudwatch" {

    role = aws_iam_role.lambda_line_counter_role.id
    name = "${var.name}-lamda-policy"
    policy = data.aws_iam_policy_document.lambda_logging_policy.json

}
