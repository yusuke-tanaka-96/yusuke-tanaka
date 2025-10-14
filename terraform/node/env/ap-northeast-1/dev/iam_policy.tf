locals {
  apigateway-role = {
    trusted_entities = ["apigateway.amazonaws.com"]
    policy_arns = [
      "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
    ]
    inline_policies = [
      {
        name = "apigateway-inline-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : "lambda:InvokeFunction",
              "Resource" : "arn:aws:lambda:${local.region}:${local.aws_account}:function:*"
            }
          ]
        })
      }
    ]

  }

  s3-logs-bucket = {
    bucket_policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : [
            "s3:PutBucketPolicy",
            "s3:GetBucketPolicy",
            "s3:PutObject",
            "s3:GetObject"
          ],
          "Resource" : "arn:aws:s3:::portfolio-logs-bucket/*"
        }
      ]
    })
    lifecycle_rules = [
      {
        id              = "delete-old-logs"
        status          = "Enabled"
        prefix          = "logs/"
        expiration_days = 30
      },
      {
        id              = "archive-older-logs"
        status          = "Enabled"
        prefix          = "archive/"
        expiration_days = 90
      }
    ]
  }

  ecs-task-execution-role = {
    trusted_entities = ["ecs-tasks.amazonaws.com"]
    service_condition = {
      Sid = "EcsTaskAssume"
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = local.aws_account
        }
      }
    }

    inline_policies = [
      {
        name = "ecs-task-execution-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Sid" : "EcrToken",
              "Effect" : "Allow",
              "Action" : ["ecr:GetAuthorizationToken"],
              "Resource" : ["*"], # このAPIはリソースレベル制限をサポートしていない
              "Condition" : {
                "StringEquals" : {
                  "aws:RequestedRegion" : data.aws_region.current.name,
                  "aws:PrincipalAccount" : data.aws_caller_identity.current.account_id
                }
              }
            },
            {
              "Sid" : "EcrPull",
              "Effect" : "Allow",
              "Action" : ["ecr:BatchGetImage", "ecr:GetDownloadUrlForLayer"],
              "Resource" : ["arn:aws:ecr:${local.region}:${local.aws_account}:repository/${local.name_prefix}-*"]
            },
            {
              "Sid" : "LogsWrite",
              "Effect" : "Allow",
              "Action" : ["logs:CreateLogStream", "logs:PutLogEvents"],
              "Resource" : ["arn:aws:logs:${local.region}:${local.aws_account}:log-group:/aws/ecs/*:log-stream:*"]
            },
            {
              "Effect" : "Allow",
              "Action" : ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"],
              "Resource" : ["arn:aws:secretsmanager:*:*:secret:*"] //TODO: 本当は絞る（設計書もれ）
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "kms:Decrypt",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
              ],
              "Resource" : [local.kms_key_arn] //TODO: 本当は絞る（設計書もれ）
            },
            {
              "Effect" : "Allow",
              "Action" : ["ssm:GetParameters", "ssm:GetParameter"],
              "Resource" : [
                "arn:aws:ssm:${local.region}:${local.aws_account}:parameter/${local.env}/*",
                "arn:aws:ssm:${local.region}:${local.aws_account}:parameter/sysdig/*",
                "arn:aws:ssm:${local.region}:${local.aws_account}:parameter/acmpca/*"
              ]
            },
            # sysdig用の権限
            {
              "Sid" : "AllowSysdigTokenRead",
              "Effect" : "Allow",
              "Action" : ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"],
              "Resource" : "arn:aws:secretsmanager:${local.region}:${local.aws_account}:secret:sysdig-api-key-*"
            }
          ]
        })
      }
    ]
  }

  ecs-api-task-role = {
    trusted_entities = ["ecs-tasks.amazonaws.com"]
    service_condition = {
      Sid = "EcsTaskAssume"
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = local.aws_account
        }
      }
    }

    inline_policies = [
      {
        name = "ecs-api-task-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Sid" : "RdsConnect",
              "Effect" : "Allow",
              "Action" : ["rds-db:connect"],
              "Resource" : ["${module.aurora.instance_arn}/*"]
            },
            {
              "Sid" : "Secrets",
              "Effect" : "Allow",
              "Action" : ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"],
              "Resource" : ["arn:aws:secretsmanager:*:*:secret:*"] //TODO: 本当は絞る
            },
            {
              "Sid" : "KmsDecrypt",
              "Effect" : "Allow",
              "Action" : ["kms:Decrypt"],
              "Resource" : [local.kms_key_arn],
              "Condition" : {
                "StringEquals" : {
                  "kms:EncryptionContext:aws:secretsmanager:arn" : "arn:aws:secretsmanager:${local.region}:${local.aws_account}:secret:*" //TODO: 本当は絞る
                }
              }
            },
            {
              "Sid" : "APIGatewayReadWrite",
              "Effect" : "Allow",
              "Action" : ["apigateway:GET", "apigateway:POST", "apigateway:PUT", "apigateway:PATCH", "apigateway:DELETE"],
              "Resource" : [
                "arn:aws:apigateway:${local.region}::/restapis/*",
                "arn:aws:apigateway:${local.region}::/tags/*"
              ]
            }
          ]
        })
      }
    ]
  }

  ecs-mgmt-task-role = {
    trusted_entities = ["ecs-tasks.amazonaws.com"]
    service_condition = {
      Sid = "EcsTaskAssume"
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = local.aws_account
        }
      }
    }

    inline_policies = [
      {
        name = "ecs-mgmt-task-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : [
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:CreateSecret",
                "secretsmanager:DeleteSecret",
              ],
              "Resource" : ["arn:aws:secretsmanager:*:*:secret:*"] //TODO: 本当は絞る
            },
            {
              "Effect" : "Allow",
              "Action" : ["states:SendTaskSuccess", "states:SendTaskFailure"],
              "Resource" : [module.step_functions_exec_batch.state_machine_arn, module.step_functions_delete_tenant.state_machine_arn]
            },
            {
              "Effect" : "Allow",
              "Action" : ["events:PutEvents"],
              "Resource" : ["arn:aws:events:${local.region}:${local.aws_account}:event-bus/default"]
            },
            {
              "Effect" : "Allow",
              "Action" : ["kms:Decrypt"],
              "Resource" : [local.kms_key_arn],
              "Condition" : {
                "StringEquals" : {
                  "kms:EncryptionContext:aws:secretsmanager:arn" : "arn:aws:secretsmanager:${local.region}:${local.aws_account}:secret:*" //TODO: 本当は絞る
                }
              }
            },
            {
              "Sid" : "APIGatewayReadWrite",
              "Effect" : "Allow",
              "Action" : ["apigateway:GET", "apigateway:POST", "apigateway:PUT", "apigateway:PATCH", "apigateway:DELETE"],
              "Resource" : [
                "arn:aws:apigateway:${local.region}::/restapis/*",
                "arn:aws:apigateway:${local.region}::/tags/*",
                "arn:aws:apigateway:${local.region}::/apikeys*",
                "arn:aws:apigateway:${local.region}::/usageplans",
                "arn:aws:apigateway:${local.region}::/usageplans/*",
                "arn:aws:apigateway:${local.region}::/usageplans/*/keys"
              ]
            }
          ]
        })
      }
    ]
  }

  lambda-auth-tenant-role = {
    trusted_entities = ["lambda.amazonaws.com"]
    service_condition = {
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = local.aws_account
        }
      }
    }

    inline_policies = [
      {
        name = "lambda-auth-tenant-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
              "Resource" : ["${module.cwlogs-lambda-auth-tenant.log_group_arn}:*"]
            },
            {
              "Effect" : "Allow",
              "Action" : ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"],
              "Resource" : ["arn:aws:secretsmanager:*:*:secret:*"] //TODO: 本当は絞る
            },
            {
              "Effect" : "Allow",
              "Action" : ["kms:Decrypt"],
              "Resource" : [local.kms_key_arn]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface"
              ],
              "Resource" : ["*"], # これらのAPIはリソースレベル制限をサポートしていない
              "Condition" : {
                "StringEquals" : {
                  "aws:RequestedRegion" : data.aws_region.current.name
                }
              }
            }
          ]
        })
      }
    ]
  }

  ec2-bastion-instance-role = {
    trusted_entities = ["ec2.amazonaws.com"]
    service_condition = {
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = local.aws_account
        }
      }
    }

    policy_arns = [
      "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
      "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]

    inline_policies = [
      {
        name = "ec2-bastion-instance-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : ["ssm:UpdateInstanceInformation", "ssmmessages:*", "ec2messages:*"],
              "Resource" : ["*"]
            },
            {
              "Effect" : "Allow",
              "Action" : ["logs:CreateLogStream", "logs:PutLogEvents"],
              "Resource" : ["*"]
            },
            {
              "Effect" : "Allow",
              "Action" : ["secretsmanager:GetSecretValue"],
              "Resource" : ["arn:aws:secretsmanager:*:*:secret:*"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
              ],
              "Resource" : ["arn:aws:logs:${local.region}:${local.aws_account}:log-group:/ec2/*:*"]
            },
          ]
        })
      }
    ]
  }

  ec2-node-instance-role = {
    trusted_entities = ["ec2.amazonaws.com"]
    service_condition = {
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = local.aws_account
        }
      }
    }

    policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]

    inline_policies = [
      {
        name = "ec2-node-instance-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : ["logs:CreateLogStream", "logs:DescribeLogStreams", "logs:PutLogEvents"],
              "Resource" : [
                "${module.cwlogs-ec2-node-instance-pf1.log_group_arn}:*",
                "${module.cwlogs-ec2-node-instance-pf2.log_group_arn}:*",
                "${module.cwlogs-ec2-node-instance-pf1-nginx-access.log_group_arn}:*",
                "${module.cwlogs-ec2-node-instance-pf2-nginx-access.log_group_arn}:*",
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"],
              "Resource" : ["arn:aws:secretsmanager:*:*:secret:*"] //TODO: 本当は絞る
            },
            {
              "Effect" : "Allow",
              "Action" : ["s3:PutObject", "s3:GetObject", "s3:ListBucket"],
              "Resource" : ["${local.s3_ext_node_health_arn}/*", "${local.s3_ext_node_health_arn}"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "ec2:DescribeTags",
                "ec2:DescribeVpcEndpoints",
                "ec2:DescribeSnapshots",
                "ec2:DescribeInstances",
                "ec2:DescribeVolumes",
                "ec2:DescribeImages",
                "ec2:CreateImage",
                "ec2:CreateSnapshot"
              ],
              "Resource" : "*"
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "ec2:ModifyInstanceAttribute",
                "ec2:CreateTags",
                "ec2:DeleteTags"
              ],
              "Resource" : [
                "arn:aws:ec2:${local.region}:${local.aws_account}:instance/*",
                "arn:aws:ec2:${local.region}:${local.aws_account}:volume/*",
                "arn:aws:ec2:${local.region}::snapshot/*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "ec2:AttachVolume",
                "ec2:CreateVolume"
              ],
              "Resource" : [
                "arn:aws:ec2:${local.region}:${local.aws_account}:*",
                "arn:aws:ec2:${local.region}::snapshot/*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "autoscaling:CompleteLifecycleAction",
                "autoscaling:RecordLifecycleActionHeartbeat"
              ],
              "Resource" : [
                "arn:aws:autoscaling:${local.region}:${local.aws_account}:autoScalingGroup:*:autoScalingGroupName/portfolio-*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "autoscaling:DescribeAutoScalingInstances",
                "cloudwatch:PutMetricData"
              ],
              "Resource" : [
                "*"
              ]
            }
          ]
        })
      }
    ]
  }


  codepipeline-service-role = {
    trusted_entities = ["codepipeline.amazonaws.com"]
    service_condition = {
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = local.aws_account
        }
        ArnLike = {
          "aws:SourceArn" = "arn:aws:codepipeline:${local.region}:${local.aws_account}:*"
        } // TODO: 絞る（設計書もれ）
      }
    }

    inline_policies = [
      {
        name = "codepipeline-service-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : ["codepipeline:*"],
              "Resource" : ["arn:aws:codepipeline:${local.region}:${local.aws_account}:pipeline/${local.name_prefix}-*"]
            },
            {
              "Effect" : "Allow",
              "Action" : ["codestar-connections:UseConnection"],
              "Resource" : ["*"] //TODO: 絞る（設計書もれ）
            },
            {
              "Effect" : "Allow",
              "Action" : ["codebuild:StartBuild", "codebuild:BatchGetBuilds"],
              "Resource" : ["arn:aws:codebuild:${local.region}:${local.aws_account}:project/${local.name_prefix}-*"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "codedeploy:GetApplication",
                "codedeploy:GetApplicationRevision",
                "codedeploy:GetDeployment",
                "codedeploy:GetDeploymentGroup",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:RegisterApplicationRevision",
                "codedeploy:CreateDeployment",
                "codedeploy:GetDeployment",
                "codedeploy:StopDeployment"
              ],
              "Resource" : [
                "arn:aws:codedeploy:${local.region}:${local.aws_account}:application:${local.name_prefix}-*",
                "arn:aws:codedeploy:${local.region}:${local.aws_account}:deploymentgroup:${local.name_prefix}-*",
                "arn:aws:codedeploy:${local.region}:${local.aws_account}:deploymentconfig:CodeDeployDefault.*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : ["s3:ListBucket"],
              "Resource" : ["${module.s3-codepipeline-artifacts.bucket_arn}"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:PutObject"
              ],
              "Resource" : ["${module.s3-codepipeline-artifacts.bucket_arn}/*"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "ecs:CreateTaskSet",
                "ecs:UpdateServicePrimaryTaskSet",
                "ecs:DeleteTaskSet",
                "ecs:DescribeTaskSets",
                "ecs:ListTaskSets",
                "ecs:DescribeServices",
                "ecs:DescribeTaskDefinition",
                "ecs:DescribeClusters",
                "ecs:RegisterTaskDefinition"
              ],
              "Resource" : ["*"] //TODO: 絞る（設計書もれ）
            },
            {
              "Effect" : "Allow",
              "Action" : ["iam:PassRole"],
              "Resource" : [
                module.iam-codebuild-service-role.role_arn,
                module.iam-codedeploy-service-role.role_arn,
                module.iam-ecs-api-task-execution-role.role_arn,
                module.iam-ecs-mgmt-task-execution-role.role_arn,
                module.iam-ecs-batch-task-execution-role.role_arn,
                module.iam-ecs-api-task-role.role_arn,
                module.iam-ecs-mgmt-task-role.role_arn,
                module.iam-ecs-batch-task-role.role_arn
              ],
              "Condition" : {
                "StringEquals" : {
                  "iam:PassedToService" = "ecs-tasks.amazonaws.com"
                }
              }
            }
          ]
        })
      }
    ]
  }

  codebuild-service-role = {
    trusted_entities = ["codebuild.amazonaws.com"]
    service_condition = {
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = local.aws_account
        }
      }
    }

    inline_policies = [
      {
        name = "codebuild-service-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : ["ecr:GetAuthorizationToken"],
              "Resource" : ["*"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "ecr:BatchCheckLayerAvailability",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:PutImage",
                "ecr:BatchGetImage",
                "ecr:DescribeRepositories"
              ],
              "Resource" : values(module.ecr_repositories.repository_arns)
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "ecs:DescribeTaskDefinition",
                "ecs:RegisterTaskDefinition",
                "ecs:DeregisterTaskDefinition",
                "ecs:DescribeClusters"
              ],
              "Resource" : ["*"]
            },
            {
              "Effect" : "Allow",
              "Action" : ["s3:ListBucket"],
              "Resource" : ["${module.s3-codepipeline-artifacts.bucket_arn}"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "s3:GetObject",
                "s3:PutObject",
                "s3:GetObjectVersion"
              ],
              "Resource" : ["${module.s3-codepipeline-artifacts.bucket_arn}/*"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "secretsmanager:GetSecretValue",
                "secretsmanager:CreateSecret",
                "secretsmanager:DeleteSecret",
                "secretsmanager:UpdateSecret"
              ],
              "Resource" : [
                "arn:aws:secretsmanager:${local.region}:${local.aws_account}:secret:pipeline-snyk-token-RwIF0x",
                "${module.aurora.rds_secret_arn}",
                "arn:aws:secretsmanager:${local.region}:${local.aws_account}:secret:test-*",
                "arn:aws:secretsmanager:${local.region}:${local.aws_account}:secret:*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents", "logs:FilterLogEvents"],
              "Resource" : ["arn:aws:logs:${local.region}:${local.aws_account}:log-group:/aws/codebuild/*:log-stream:*"]
            },
            {
              "Effect" : "Allow",
              "Action" : ["logs:FilterLogEvents"],
              "Resource" : ["arn:aws:logs:${local.region}:${local.aws_account}:log-group:/aws/ecs/*:log-stream:*"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "apigateway:GET",
                "apigateway:POST",
                "apigateway:PATCH",
                "apigateway:PUT",
                "apigateway:DELETE"
              ],
              "Resource" : [
                "arn:aws:apigateway:${local.region}::/restapis",
                "arn:aws:apigateway:${local.region}::/restapis/*",
                "arn:aws:apigateway:${local.region}::/usageplans",
                "arn:aws:apigateway:${local.region}::/usageplans/*",
                "arn:aws:apigateway:${local.region}::/apikeys",
                "arn:aws:apigateway:${local.region}::/apikeys/*",
                "${aws_api_gateway_rest_api.portfolio-backend-tenant-api.arn}/*",
                "${aws_api_gateway_rest_api.portfolio-backend-internal-api.arn}/*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "states:DescribeExecution",
                "states:ListExecutions",
                "states:StartExecution"
              ],
              "Resource" : [
                "${module.step_functions_exec_batch.state_machine_arn}",
                "${module.step_functions_exec_batch.state_machine_arn}:*",
                "${module.step_functions_delete_tenant.state_machine_arn}",
                "${module.step_functions_delete_tenant.state_machine_arn}:*",
                "arn:aws:states:${local.region}:${local.aws_account}:execution:*:*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface",
                "ec2:AttachNetworkInterface",
                "ec2:DetachNetworkInterface",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeDhcpOptions",
                "ec2:DescribeVpcs",
                "ec2:CreateNetworkInterfacePermission"
              ],
              "Resource" : ["*"], # これらのAPIはリソースレベル制限をサポートしていない
              "Condition" : {
                "StringEquals" : {
                  "aws:RequestedRegion" : data.aws_region.current.name
                }
              }
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "rds:DescribeDBInstances",
                "rds:DescribeDBClusters",
                "rds-db:connect"
              ],
              "Resource" : ["*"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:GetParametersByPath"
              ],
              "Resource" : [
                "arn:aws:ssm:${local.region}:${local.aws_account}:parameter/${local.environment}/*",
                "arn:aws:ssm:${local.region}:${local.aws_account}:parameter/acmpca/*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "rds-data:ExecuteStatement",
                "rds-data:BatchExecuteStatement",
                "rds-data:BeginTransaction",
                "rds-data:CommitTransaction",
                "rds-data:RollbackTransaction"
              ],
              "Resource" : ["${module.aurora.cluster_arn}"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "states:StartExecution",
                "states:DescribeExecution",
                "states:StopExecution"
              ],
              "Resource" : [
                module.step_functions_exec_batch.state_machine_arn,
                module.step_functions_delete_tenant.state_machine_arn
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
              ],
              "Resource" : [
                "${module.s3-codepipeline-artifacts.bucket_arn}/*",
                "${module.s3-firehose-backup.bucket_arn}/*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "s3:ListBucket"
              ],
              "Resource" : [
                module.s3-codepipeline-artifacts.bucket_arn,
                module.s3-firehose-backup.bucket_arn
              ]
            }
          ]
        })
      }
    ]
  }

  codedeploy-service-role = {
    trusted_entities = ["codedeploy.amazonaws.com"]
    service_condition = {
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = local.aws_account
        }
      }
    }

    policy_arns = ["arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"]

    inline_policies = [
      {
        name = "codedeploy-service-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : ["iam:PassRole"],
              "Resource" : [
                module.iam-ecs-api-task-execution-role.role_arn,
                module.iam-ecs-mgmt-task-execution-role.role_arn,
                module.iam-ecs-batch-task-execution-role.role_arn,
                module.iam-ecs-api-task-role.role_arn,
                module.iam-ecs-mgmt-task-role.role_arn,
                module.iam-ecs-batch-task-role.role_arn
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "ecs:DescribeServices",
                "ecs:UpdateService",
                "ecs:DescribeTaskDefinition",
                "ecs:RegisterTaskDefinition",
                "ecs:DescribeClusters",
                "ecs:DeregisterTaskDefinition"
              ],
              "Resource" : ["*"] //TODO: 本当は絞る（設計書もれ）
            },
            {
              "Effect" : "Allow",
              "Action" : ["s3:ListBucket"],
              "Resource" : ["${module.s3-codepipeline-artifacts.bucket_arn}"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "s3:GetObject",
                "s3:GetObjectVersion"
              ],
              "Resource" : ["${module.s3-codepipeline-artifacts.bucket_arn}/*"]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
              ],
              "Resource" : ["*"] //TODO: 本当は絞る（設計書もれ）
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "codedeploy:GetApplication",
                "codedeploy:ListApplications",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:GetDeploymentGroup",
                "codedeploy:ListDeploymentGroups",
                "codedeploy:GetDeployment",
                "codedeploy:ListDeployments",
                "codedeploy:ContinueDeployment",
                "codedeploy:StopDeployment",
                "codedeploy:BatchGetDeploymentTargets",
                "codedeploy:TagResource",
                "codedeploy:UntagResource"
              ],
              "Resource" : [
                "arn:aws:codedeploy:${local.region}:382828593760:application:portfolio*",
                "arn:aws:codedeploy:${local.region}:382828593760:deploymentgroup:portfolio*:portfolio*",
                "arn:aws:codedeploy:${local.region}:382828593760:deploymentconfig:CodeDeployDefault.*"
              ] //TODO: module参照する（設計書もれ）
            }
          ]
        })
      }
    ]
  }

  lambda-secrets-manager-rotati-role = {
    trusted_entities = ["lambda.amazonaws.com"]
    policy_arns = [
      "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
    ]
    service_condition = {
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = local.aws_account
        }
      }
    }

    inline_policies = [
      {
        name = "lambda-secrets-manager-rotati-inline-policy"
        content = jsonencode({
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : [
                "secretsmanager:GetRandomPassword"
              ],
              "Resource" : "*"
            },
            {
              "Action" : [
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface"
              ],
              "Condition" : {
                "StringEquals" : {
                  "aws:RequestedRegion" : "ap-northeast-1"
                }
              },
              "Effect" : "Allow",
              "Resource" : [
                "*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "rds:DescribeDBClusters",
                "rds:DescribeDBInstances"
              ],
              "Resource" : "*"
            },
            {
              "Effect" : "Allow",
              "Action" : "logs:CreateLogGroup",
              "Resource" : "arn:aws:logs:ap-northeast-1:${local.aws_account}:*"
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
              ],
              "Resource" : [
                "${module.cwlogs_lambda_secrets_manager_rotation.log_group_arn}:*"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "secretsmanager:DescribeSecret",
                "secretsmanager:GetSecretValue",
                "secretsmanager:GetRandomPassword"
              ],
              "Resource" : [
                "${module.secrets-manager-rds-cluster.secret_arn}",
                "${module.aurora.rds_secret_arn}"
              ]
            },
            {
              "Effect" : "Allow",
              "Action" : [
                "secretsmanager:PutSecretValue",
                "secretsmanager:UpdateSecretVersionStage"
              ],
              "Resource" : [
                "${module.secrets-manager-rds-cluster.secret_arn}"
              ]
            }
          ]
        })
      }
    ]
  }
}
