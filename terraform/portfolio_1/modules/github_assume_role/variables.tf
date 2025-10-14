variable "role_name" {
  type        = string
  description = "IAM Role の名前"
}

variable "github_repositories" {
  type        = list(string)
  description = "OIDCで許可するGitHubリポジトリ（org/repo 形式）"
}

variable "oidc_provider_arn" {
  type        = string
  default     = null
  description = "OIDCプロバイダーのARN（nullなら現在のアカウントから自動生成）"
}

variable "inline_policy_json" {
  type        = string
  default     = null
  description = "JSON形式のインラインポリシー（任意）"
}

variable "merged_tags" {
  type        = map(string)
  default     = {}
  description = "IAM Roleに付与するタグ"
}
