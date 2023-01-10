variable "name" {}
variable "lambda_source_dir" {}
variable "role_arn" {}
variable "lambda_handler" {}
variable "function_runtime" {}
variable "function_name" {}
variable "memory_size" {}
variable "timeout" {}
variable "log_retention_in_days" {}
variable "tag_terraform_value" {
  type = string
  default = "cnt_line_msg_remain_num"
  description = "lambda関数のtag名"
}
variable "archive_file_type" {
  type = string
  default = "zip"
  description = "zip形式で構成ファイルをまとめる"
}
variable "deploy_upload_filename" {
  type = string
  default = "lambda_src.zip"
  description = "zip構成ファイル名"
}

