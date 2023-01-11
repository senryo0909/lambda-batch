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
data "aws_iam_policy_document" "lambda_logging_policy_document" {

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}
# lambda_logging_policy_documentからlambdaのcloudwatchポリシーを生成(他にもattacheできるようにしたが、作成時のアカウントに存在すれば不要)
resource "aws_iam_policy" "lambda_logging_policy" {
  name        = "lambda_logging_policy"
  description = "A test policy"

  policy = data.aws_iam_policy_document.lambda_logging_policy_document.json
}

# lambda_logging_policyをlambda_line_counter_roleにアタッチ
resource "aws_iam_policy_attachment" "lambda_logging_policy_to_lambda_line_counter_role" {
  name       = "attach_lambda_logging_policy_to_lambda_line_counter_role"
  roles      = [aws_iam_role.lambda_line_counter_role.name]
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}


# OIDCの設定
# 証明書サムプリント生成
data "tls_certificate" "github_actions" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

# IDプロバイダーの設定
resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github_actions.certificates[0].sha1_fingerprint]
}

# GitHub Actionsで使用するrole
resource "aws_iam_role" "github_actions" {
  name               = "github-actions"
  assume_role_policy = data.aws_iam_policy_document.github_actions.json
  description        = "membersrole"
}

# 信頼関係の記載(OIDCプロバイダーとrole)
data "aws_iam_policy_document" "github_actions" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github_actions.arn
      ]
    }

    # OIDCを利用できる対象のGitHub Repositoryを制限する
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [var.full_paths]
    }
  }
}

# 実際に利用する際にはこれに加えてdeny定義を追加付与するなどして、CI/CD用にカスタマイズすることを強く推奨
resource "aws_iam_role_policy_attachment" "admin" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.github_actions.name
}

