variable "name" {
  type        = string
  default     = "cnt_line_msg_remain_num"
  description = "各サービスに合わせてdefault値を変更可能"
}

variable "full_paths" {
  type        = string
  default     = "repo:senryo0909/lambda-batch:ref:refs/heads/main"
  description = "認可するgithubのリモートリポジトリのorganization/repositoryname:ブランチ名を限定"
}

