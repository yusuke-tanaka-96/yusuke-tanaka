# 1) CA 本体を作成（最初は PENDING_CERTIFICATE）
resource "aws_acmpca_certificate_authority" "this" {
  type = var.is_root ? "ROOT" : "SUBORDINATE"

  certificate_authority_configuration {
    key_algorithm     = var.key_algorithm
    signing_algorithm = var.signing_algorithm
    subject {
      common_name         = var.subject_common_name
      country             = var.subject_country
      organization        = var.subject_organization
      organizational_unit = var.subject_organizational_unit
      state               = var.subject_state
      locality            = var.subject_locality
    }
  }
  enabled = var.enabled
}

# 2) Root の自動アクティブ化（自己署名）: Issue → Import
resource "aws_acmpca_certificate" "root_self_signed" {
  count = var.is_root && var.auto_activate ? 1 : 0

  certificate_authority_arn   = aws_acmpca_certificate_authority.this.arn # 自身で自己署名
  certificate_signing_request = aws_acmpca_certificate_authority.this.certificate_signing_request

  signing_algorithm = var.signing_algorithm
  template_arn      = var.template_root_arn

  validity {
    type  = "YEARS"
    value = var.validity_years
  }
}

resource "aws_acmpca_certificate_authority_certificate" "root_import" {
  count = var.is_root && var.auto_activate ? 1 : 0

  certificate_authority_arn = aws_acmpca_certificate_authority.this.arn
  certificate               = aws_acmpca_certificate.root_self_signed[0].certificate
  # Root はチェーンなし
}

# 3) Subordinate の自動アクティブ化（親 CA で署名）: Issue（親）→ Import（子）
resource "aws_acmpca_certificate" "sub_signed_by_parent" {
  count = (!var.is_root && var.auto_activate && var.parent_ca_arn != null) ? 1 : 0

  certificate_authority_arn   = var.parent_ca_arn # 署名するのは親CA
  certificate_signing_request = aws_acmpca_certificate_authority.this.certificate_signing_request

  signing_algorithm = var.signing_algorithm
  template_arn      = var.template_subordinate_arn

  validity {
    type  = "YEARS"
    value = var.validity_years
  }
}

resource "aws_acmpca_certificate_authority_certificate" "sub_import" {
  count = (!var.is_root && var.auto_activate && var.parent_ca_arn != null) ? 1 : 0

  certificate_authority_arn = aws_acmpca_certificate_authority.this.arn
  certificate               = aws_acmpca_certificate.sub_signed_by_parent[0].certificate
  certificate_chain         = aws_acmpca_certificate.sub_signed_by_parent[0].certificate_chain
}

# 4) ACM からの自動発行を許可（任意）
resource "aws_acmpca_permission" "acm" {
  count = var.grant_acm_permission ? 1 : 0

  certificate_authority_arn = aws_acmpca_certificate_authority.this.arn
  actions                   = ["IssueCertificate", "GetCertificate", "ListPermissions"]
  principal                 = "acm.amazonaws.com"
  source_account            = var.acm_source_account
}
