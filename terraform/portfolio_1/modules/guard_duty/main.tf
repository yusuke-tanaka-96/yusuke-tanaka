resource "aws_guardduty_detector" "this" {
  enable = var.enable_detector

  datasources {
    s3_logs {
      enable = var.enable_s3_protection
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = var.enable_malware_protection
        }
      }
    }
  }
}

# Temporarily commented out due to KMS permission error
resource "aws_guardduty_publishing_destination" "this" {
  count = var.enable_publishing_destination ? 1 : 0

  detector_id     = aws_guardduty_detector.this.id
  destination_arn = var.destination_s3_arn
  kms_key_arn     = var.kms_key_arn
  depends_on      = [aws_guardduty_detector.this]
}
