# Aurora クラスタ名
variable "cluster_identifier" {
  description = "Identifier for the Aurora cluster"
  type        = string
}

# DB名
variable "database_name" {
  description = "Name of the initial database to be created"
  type        = string
}

# マスターユーザー名
variable "master_username" {
  description = "Master username for the Aurora cluster"
  type        = string
}

#マスターユーザパスワード
variable "manage_master_user_password" {
  description = "Whpf2er to manage the master user password with AWS Secrets Manager"
  type        = bool
  default     = false
}

# Auroraエンジンバージョン
variable "engine_version" {
  description = "Aurora PostgreSQL engine version"
  type        = string
  default     = "15.3"
}

#readerの追加
variable "reader_count" {
  type    = number
  default = 0
}


# DBサブネットグループに使う subnet_ids
variable "subnet_ids" {
  description = "List of subnet IDs for the Aurora DB subnet group"
  type        = list(string)
}

# セキュリティグループのIDリスト
variable "security_group_ids" {
  description = "List of security group IDs to associate with Aurora cluster"
  type        = list(string)
}

# インスタンスクラス（例: db.t4g.medium）
variable "instance_class" {
  description = "Instance class for Aurora instances"
  type        = string
  default     = "db.t4g.medium"
}

# リソースに共通で付けるタグ
variable "merged_tags" {
  description = "Tags to apply to all Aurora resources"
  type        = map(string)
}

# ネームプレフィックス
variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = ""
}

# ネームサフィックス
variable "name_suffix" {
  description = "Suffix for naming resources"
  type        = string
  default     = ""
}

# バックアップ保持日数
variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

# Final snapshot をスキップするか
variable "skip_final_snapshot" {
  description = "Whpf2er to skip final snapshot on deletion"
  type        = bool
  default     = true
}

# インターネットからのアクセスを許可するか
variable "publicly_accessible" {
  description = "Whpf2er the DB instance is publicly accessible"
  type        = bool
  default     = false
}
