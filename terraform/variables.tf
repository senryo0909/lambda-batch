variable "region" {
  default = "ap-northeast-1"
}

variable "tf_s3_bucket" {
  default = "member-s-line-counter"
}

# 外部変数設定ファイル
variable "app_name" {
  default = "member-s-line-counter"
}