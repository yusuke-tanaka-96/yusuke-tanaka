resource "aws_ecr_repository" "this" {
  for_each = { for repo in var.repositories : repo.name => repo }

  name                 = each.value.name
  image_tag_mutability = each.value.image_tag_mutability

  encryption_configuration {
    encryption_type = each.value.encryption_type
    kms_key         = each.value.kms_key
  }

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }

  tags = try(each.value.tags, {})
}
