variable "name" {
  type = string
}
variable "lambda_source_dir" {
  type = string
}
variable "role_arn" {
  type = string
}
variable "lambda_handler" {
  type = string
}
variable "function_runtime" {
  type = string
}
variable "function_name" {
  type = string
}
variable "memory_size" {
  type = number
}
variable "timeout" {
  type = number
}
variable "log_retention_in_days" {
  type = number
}
variable "tag_terraform_value" {
  type        = string
  default     = "cnt_line_msg_remain_num"
  description = "lambda関数のtag名"
}
variable "archive_file_type" {
  type        = string
  default     = "zip"
  description = "zip形式で構成ファイルをまとめる"
}
variable "deploy_upload_filename" {
  type        = string
  default     = "lambda_src.zip"
  description = "zip構成ファイル名"
}

