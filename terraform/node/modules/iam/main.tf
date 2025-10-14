resource "aws_iam_role" "this" {
  name        = var.role_name
  description = var.role_description

  assume_role_policy = (
    length(var.assume_role_policy) > 0 ?
    var.assume_role_policy[0].content :
    jsonencode({
      Version = "2012-10-17",
      Statement = flatten([
        [
          for entity in var.trusted_entities : merge(
            {
              Effect    = "Allow"
              Principal = { Service = entity }
              Action    = "sts:AssumeRole"
            },
            var.service_condition
          )
        ],
        (length(var.federated_entities) > 0 && length(var.federated_action) > 0) ? [{
          Effect    = "Allow"
          Principal = { Federated = var.federated_entities }
          Action    = var.federated_action
          Condition = var.federated_condition
        }] : [],
        length(var.aws_entities) > 0 ? [{
          Effect    = "Allow"
          Principal = { AWS = var.aws_entities }
          Action    = "sts:AssumeRole"
        }] : []
      ])
    })
  )

  tags = merge(var.merged_tags, {
    Name = var.role_name
  })
}


// TOOD: このpolicyはどこにもアタッチされていないので存在意義無し。確認して削除
resource "aws_iam_policy" "this" {
  count = length(var.policy_statements) > 0 ? 1 : 0

  name   = "${var.role_name}-policy"
  policy = var.policy_statements
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = var.policy_arns[count.index]
}

resource "aws_iam_role_policy" "inline" {
  count = length(var.inline_policies)

  name   = var.inline_policies[count.index].name
  role   = aws_iam_role.this.name
  policy = var.inline_policies[count.index].content
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_instance_profile ? 1 : 0
  name  = "${aws_iam_role.this.name}-profile"
  role  = aws_iam_role.this.name
}
