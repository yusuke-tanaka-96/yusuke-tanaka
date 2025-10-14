variable "is_root" {
  description = "ROOT なら true、Subordinate なら false"
  type        = bool
  default     = true
}
variable "enabled" {
  type    = bool
  default = true
}

variable "key_algorithm" {
  description = "CA鍵アルゴリズム (RSA_2048, RSA_4096, EC_prime256v1, EC_secp384r1)"
  type        = string
  default     = "RSA_2048"
}

variable "signing_algorithm" {
  description = "署名アルゴリズム (SHA256WITHRSA など)"
  type        = string
  default     = "SHA256WITHRSA"
}

variable "subject_common_name" {
  type = string
}
variable "subject_country" {
  type    = string
  default = "JP"
}
variable "subject_organization" {
  type    = string
  default = "NTT Digital"
}
variable "subject_organizational_unit" {
  type    = string
  default = "dev"
}
variable "subject_state" {
  type    = string
  default = "Tokyo"
}
variable "subject_locality" {
  type    = string
  default = "Chiyoda"
}

variable "validity_years" {
  description = "CA 証明書の有効年数（自動発行時）"
  type        = number
  default     = 10
}

variable "auto_activate" {
  description = "作成後すぐアクティブ化（Rootは自己署名、Subordinateは親CAで署名）"
  type        = bool
  default     = true
}

variable "parent_ca_arn" {
  description = "Subordinate を自動有効化する場合の親CA ARN（is_root=false のとき）"
  type        = string
  default     = null
}

variable "grant_acm_permission" {
  description = "ACM からの自動発行を許可するか"
  type        = bool
  default     = true
}

variable "acm_source_account" {
  description = "ACM 連携で許可するアカウントID（省略可。省略時は現在のアカウント）"
  type        = string
  default     = null
}

variable "template_root_arn" {
  type    = string
  default = "arn:aws:acm-pca:::template/RootCACertificate/V1"
}

variable "template_subordinate_arn" {
  type    = string
  default = "arn:aws:acm-pca:::template/SubordinateCACertificate_PathLen0/V1"
}

variable "tags" {
  type    = map(string)
  default = {}
}
