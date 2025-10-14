#########################################
#code build
#########################################
module "codebuild" {
  source   = "../../modules/codebuild"
  projects = local.codebuild_projects
}

locals {
  codebuild_projects = [
    {
      name               = "${local.name_prefix}-build-internal-api-pj"
      build_timeout      = 60
      queued_timeout     = 480
      service_role       = module.iam-codebuild-service-role.role_arn
      encryption_key     = "arn:aws:kms:ap-northeast-1:${local.aws_account}:alias/aws/s3"
      source_version     = "develop"
      project_visibility = "PRIVATE"
      badge_enabled      = false
      artifacts = {
        type                   = "NO_ARTIFACTS"
        encryption_disabled    = false
        override_artifact_name = false
      }
      cache = {
        type  = "NO_CACHE"
        modes = []
      }
      environment = {
        compute_type                = "BUILD_GENERAL1_SMALL"
        image                       = "aws/codebuild/standard:7.0-25.04.04"
        type                        = "LINUX_CONTAINER"
        privileged_mode             = true
        image_pull_credentials_type = "CODEBUILD"
        environment_variables = [
          { name = "ECS_CONTAINER_NAME", type = "PLAINTEXT", value = "internal-api" },
          { name = "AWS_DEFAULT_REGION", type = "PLAINTEXT", value = "ap-northeast-1" },
          { name = "ECS_CLUSTER_NAME", type = "PLAINTEXT", value = "${local.name_prefix}-ecs-backend-internal-api-cluster" },
          { name = "TASK_FAMILY", type = "PLAINTEXT", value = module.ecs_backend_internal_api.ecs_task_definition_family },
          { name = "TASK_EXECUTION_ROLE_ARN", type = "PLAINTEXT", value = module.iam-ecs-api-task-execution-role.role_arn },
          { name = "ECR_REPO", type = "PLAINTEXT", value = module.ecr_repositories.repository_urls[0] },
          { name = "CONTAINER_PORT", type = "PLAINTEXT", value = "8080" }
        ]
      }
      logs_config = {
        cloudwatch_logs = {
          status            = "ENABLED"
          retention_in_days = 30
        }
        s3_logs = { status = "DISABLED", encryption_disabled = false }
      }
      source = {
        type                  = "GITHUB"
        location              = "https://github.com/nttdigital/internal-api"
        buildspec             = "pipeline/buildspec.yml"
        git_clone_depth       = 1
        insecure_ssl          = false
        report_build_status   = false
        git_submodules_config = { fetch_submodules = false }
      }
    },
    {
      name               = "${local.name_prefix}-build-internal-batch-pj"
      build_timeout      = 60
      queued_timeout     = 480
      service_role       = module.iam-codebuild-service-role.role_arn
      encryption_key     = "arn:aws:kms:ap-northeast-1:${local.aws_account}:alias/aws/s3"
      source_version     = "develop"
      project_visibility = "PRIVATE"
      badge_enabled      = false
      artifacts = {
        type                   = "NO_ARTIFACTS"
        encryption_disabled    = false
        override_artifact_name = false
      }
      cache = {
        type  = "NO_CACHE"
        modes = []
      }
      environment = {
        compute_type                = "BUILD_GENERAL1_SMALL"
        image                       = "aws/codebuild/standard:7.0-25.04.04"
        type                        = "LINUX_CONTAINER"
        privileged_mode             = true
        image_pull_credentials_type = "CODEBUILD"
        environment_variables = [
          { name = "ECS_CONTAINER_NAME", type = "PLAINTEXT", value = "batch" },
          { name = "AWS_DEFAULT_REGION", type = "PLAINTEXT", value = "ap-northeast-1" },
          { name = "ECS_CLUSTER_NAME", type = "PLAINTEXT", value = "${local.name_prefix}-ecs-backend-batch-cluster" },
          { name = "TASK_FAMILY", type = "PLAINTEXT", value = module.ecs_backend_batch.ecs_task_definition_family },
          { name = "TASK_EXECUTION_ROLE_ARN", type = "PLAINTEXT", value = module.iam-ecs-batch-task-execution-role.role_arn },
          { name = "ECR_REPO", type = "PLAINTEXT", value = module.ecr_repositories.repository_urls[1] },
          { name = "CONTAINER_PORT", type = "PLAINTEXT", value = "8080" }
        ]
      }
      logs_config = {
        cloudwatch_logs = {
          status            = "ENABLED"
          retention_in_days = 30
        }
        s3_logs = { status = "DISABLED", encryption_disabled = false }
      }
      source = {
        type                  = "GITHUB"
        location              = "https://github.com/nttdigital/internal-batch"
        buildspec             = "pipeline/buildspec.yml"
        git_clone_depth       = 1
        insecure_ssl          = false
        report_build_status   = false
        git_submodules_config = { fetch_submodules = false }
      }
    },
    {
      name               = "${local.name_prefix}-build-tenant-api-pj"
      build_timeout      = 60
      queued_timeout     = 480
      service_role       = module.iam-codebuild-service-role.role_arn
      encryption_key     = "arn:aws:kms:ap-northeast-1:${local.aws_account}:alias/aws/s3"
      source_version     = "develop"
      project_visibility = "PRIVATE"
      badge_enabled      = false
      artifacts = {
        type                   = "NO_ARTIFACTS"
        encryption_disabled    = false
        override_artifact_name = false
      }
      cache = {
        type  = "NO_CACHE"
        modes = []
      }
      environment = {
        compute_type                = "BUILD_GENERAL1_SMALL"
        image                       = "aws/codebuild/standard:7.0-25.04.04"
        type                        = "LINUX_CONTAINER"
        privileged_mode             = true
        image_pull_credentials_type = "CODEBUILD"
        environment_variables = [
          { name = "ECS_CONTAINER_NAME", type = "PLAINTEXT", value = "tenant-api" },
          { name = "AWS_DEFAULT_REGION", type = "PLAINTEXT", value = "ap-northeast-1" },
          { name = "ECS_CLUSTER_NAME", type = "PLAINTEXT", value = "${local.name_prefix}-ecs-backend-tenant-api-cluster" },
          { name = "TASK_FAMILY", type = "PLAINTEXT", value = module.ecs_backend_tenant_api.ecs_task_definition_family },
          { name = "TASK_EXECUTION_ROLE_ARN", type = "PLAINTEXT", value = module.iam-ecs-api-task-execution-role.role_arn },
          { name = "ECR_REPO", type = "PLAINTEXT", value = module.ecr_repositories.repository_urls[2] },
          { name = "CONTAINER_PORT", type = "PLAINTEXT", value = "8080" }
        ]
      }
      logs_config = {
        cloudwatch_logs = {
          status            = "ENABLED"
          retention_in_days = 30
        }
        s3_logs = { status = "DISABLED", encryption_disabled = false }
      }
      source = {
        type                  = "GITHUB"
        location              = "https://github.com/nttdigital/tenant-api"
        buildspec             = "pipeline/buildspec.yml"
        git_clone_depth       = 1
        insecure_ssl          = false
        report_build_status   = false
        git_submodules_config = { fetch_submodules = false }
      }
    },
    {
      name               = "${local.name_prefix}-build-snykscan-pj"
      build_timeout      = 60
      queued_timeout     = 480
      service_role       = module.iam-codebuild-service-role.role_arn
      encryption_key     = "arn:aws:kms:ap-northeast-1:${local.aws_account}:alias/aws/s3"
      source_version     = "develop"
      project_visibility = "PRIVATE"
      badge_enabled      = false
      artifacts = {
        type                   = "CODEPIPELINE"
        encryption_disabled    = false
        override_artifact_name = false
      }
      cache = {
        type  = "NO_CACHE"
        modes = []
      }
      environment = {
        compute_type                = "BUILD_GENERAL1_SMALL"
        image                       = "aws/codebuild/standard:7.0-25.04.04"
        type                        = "LINUX_CONTAINER"
        privileged_mode             = false
        image_pull_credentials_type = "CODEBUILD"
        environment_variables = [
          { name = "SNYK_TOKEN", type = "SECRETS_MANAGER", value = "arn:aws:secretsmanager:ap-northeast-1:${local.aws_account}:secret:pipeline-snyk-token-RwIF0x" }
        ]
      }
      logs_config = {
        cloudwatch_logs = {
          status            = "ENABLED"
          retention_in_days = 30
        }
        s3_logs = { status = "DISABLED", encryption_disabled = false }
      }
      source = {
        type            = "CODEPIPELINE"
        location        = ""
        buildspec       = "pipeline/buildspec-snyk.yml"
        git_clone_depth = 1
        git_submodules_config = {
          fetch_submodules = false
        }
        insecure_ssl        = false
        report_build_status = false
      }
    }
  ]
}


#########################################
#code deploy
#########################################
module "codedeploy" {
  source            = "../../modules/codedeploy"
  app_name          = "${local.name_prefix}-deploy-cicd-app"
  service_role_arn  = module.iam-codedeploy-service-role.role_arn
  deployment_groups = local.deployment_groups
  tags              = local.merged_tags
}

locals {
  deployment_groups = [
    {
      deployment_group_name = "${local.name_prefix}-deploy-tenant-api-dg"
      cluster_name          = module.ecs_backend_tenant_api.ecs_cluster_name
      service_name          = "service-tenant-api"
      listener_arns         = [module.elb-backend-tenant-api.lb_listener_main_arn]
      target_group_blue     = module.elb-backend-tenant-api.lb_target_group_name_blue
      target_group_green    = module.elb-backend-tenant-api.lb_target_group_name_green
    },
    {
      deployment_group_name = "${local.name_prefix}-deploy-internal-api-dg"
      cluster_name          = module.ecs_backend_internal_api.ecs_cluster_name
      service_name          = "service-internal-api"
      listener_arns         = [module.elb-backend-internal-api.lb_listener_main_arn]
      target_group_blue     = module.elb-backend-internal-api.lb_target_group_name_blue
      target_group_green    = module.elb-backend-internal-api.lb_target_group_name_green
    }
  ]
}


#########################################
#code pipeline
#########################################
module "codepipeline" {
  source    = "../../modules/codepipeline"
  pipelines = local.codepipeline_definitions
}

locals {
  codepipeline_definitions = [
    # tenant-api
    {
      name           = "${local.name_prefix}-pipeline-tenant-api"
      role_arn       = module.iam-codepipeline-service-role.role_arn
      pipeline_type  = "V2"
      execution_mode = "QUEUED"
      artifact_store = {
        type     = "S3"
        location = module.s3-codepipeline-artifacts.bucket_name
      }
      stages = [
        {
          name = "Source"
          actions = [{
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeStarSourceConnection"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "SourceVariables"
            output_artifacts = ["SourceArtifact"]
            input_artifacts  = []
            configuration = {
              BranchName           = "develop"
              ConnectionArn        = "arn:aws:codeconnections:ap-northeast-1:${local.aws_account}:connection/83fdeb97-c9d4-4a28-9c35-775c9498f156"
              DetectChanges        = "false"
              FullRepositoryId     = "nttdigital/tenant-api"
              OutputArtifactFormat = "CODE_ZIP"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        },
        {
          name = "Build"
          actions = [{
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "BuildVariables"
            output_artifacts = ["BuildArtifact"]
            input_artifacts  = ["SourceArtifact"]
            configuration = {
              ProjectName = "${local.name_prefix}-build-tenant-api-pj"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        },
        {
          name = "SnykScan"
          actions = [{
            name             = "SnykScan"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "${local.name_prefix}-tenant-api-snyk-scan"
            output_artifacts = []
            input_artifacts  = ["SourceArtifact"]
            configuration = {
              ProjectName = "${local.name_prefix}-build-snykscan-pj"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        },
        {
          name = "Deploy"
          actions = [{
            name             = "Deploy"
            category         = "Deploy"
            owner            = "AWS"
            provider         = "CodeDeployToECS"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "DeployVariables"
            output_artifacts = []
            input_artifacts  = ["BuildArtifact"]
            configuration = {
              AppSpecTemplateArtifact        = "BuildArtifact"
              AppSpecTemplatePath            = "appspec.yml"
              ApplicationName                = "${local.name_prefix}-deploy-cicd-app"
              DeploymentGroupName            = "${local.name_prefix}-deploy-tenant-api-dg"
              TaskDefinitionTemplateArtifact = "BuildArtifact"
              TaskDefinitionTemplatePath     = "taskdef.json"
            }
          }]
          on_failure = {
            result = "ROLLBACK"
          }
        }
      ]
    },
    # internal-api
    {
      name           = "${local.name_prefix}-pipeline-internal-api"
      role_arn       = module.iam-codepipeline-service-role.role_arn
      pipeline_type  = "V2"
      execution_mode = "QUEUED"
      artifact_store = {
        type     = "S3"
        location = module.s3-codepipeline-artifacts.bucket_name
      }
      stages = [
        {
          name = "Source"
          actions = [{
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeStarSourceConnection"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "SourceVariables"
            output_artifacts = ["SourceArtifact"]
            input_artifacts  = []
            configuration = {
              BranchName           = "develop"
              ConnectionArn        = "arn:aws:codeconnections:ap-northeast-1:${local.aws_account}:connection/83fdeb97-c9d4-4a28-9c35-775c9498f156"
              DetectChanges        = "false"
              FullRepositoryId     = "nttdigital/internal-api"
              OutputArtifactFormat = "CODE_ZIP"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        },
        {
          name = "Build"
          actions = [{
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "BuildVariables"
            output_artifacts = ["BuildArtifact"]
            input_artifacts  = ["SourceArtifact"]
            configuration = {
              ProjectName = "${local.name_prefix}-build-internal-api-pj"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        },
        {
          name = "SnykScan"
          actions = [{
            name             = "SnykScan"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "${local.name_prefix}-internal-api-snyk-scan"
            output_artifacts = []
            input_artifacts  = ["SourceArtifact"]
            configuration = {
              ProjectName = "${local.name_prefix}-build-snykscan-pj"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        },
        {
          name = "Deploy"
          actions = [{
            name             = "Deploy"
            category         = "Deploy"
            owner            = "AWS"
            provider         = "CodeDeployToECS"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "DeployVariables"
            output_artifacts = []
            input_artifacts  = ["BuildArtifact"]
            configuration = {
              AppSpecTemplateArtifact        = "BuildArtifact"
              AppSpecTemplatePath            = "appspec.yml"
              ApplicationName                = "${local.name_prefix}-deploy-cicd-app"
              DeploymentGroupName            = "${local.name_prefix}-deploy-internal-api-dg"
              TaskDefinitionTemplateArtifact = "BuildArtifact"
              TaskDefinitionTemplatePath     = "taskdef.json"
            }
          }]
          on_failure = {
            result = "ROLLBACK"
          }
        }
      ]
    },
    {
      name           = "${local.name_prefix}-pipeline-test-scripts"
      role_arn       = module.iam-codepipeline-service-role.role_arn
      pipeline_type  = "V2"
      execution_mode = "QUEUED"
      artifact_store = {
        type     = "S3"
        location = module.s3-codepipeline-artifacts.bucket_name
      }
      stages = [
        {
          name = "Source"
          actions = [{
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeStarSourceConnection"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "SourceVariables"
            output_artifacts = ["SourceArtifact"]
            input_artifacts  = []
            configuration = {
              BranchName           = "develop"
              ConnectionArn        = "arn:aws:codeconnections:ap-northeast-1:${local.aws_account}:connection/83fdeb97-c9d4-4a28-9c35-775c9498f156"
              DetectChanges        = "false"
              FullRepositoryId     = "nttdigital/test-scripts"
              OutputArtifactFormat = "CODE_ZIP"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        },
        {
          name = "SnykScan"
          actions = [{
            name             = "SnykScan"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "${local.name_prefix}-internal-batch-snyk-scan"
            output_artifacts = []
            input_artifacts  = ["SourceArtifact"]
            configuration = {
              ProjectName = "${local.name_prefix}-build-snykscan-pj"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        },
        {
          name = "Test"
          actions = [{
            name             = "Test"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "TestVariables"
            output_artifacts = []
            input_artifacts  = ["SourceArtifact"]
            configuration = {
              ProjectName = "${local.name_prefix}-test-all-pj"
            }
          }]
        }
      ]
    },
    # internal-batch
    {
      name           = "${local.name_prefix}-pipeline-internal-batch"
      role_arn       = module.iam-codepipeline-service-role.role_arn
      pipeline_type  = "V2"
      execution_mode = "QUEUED"
      artifact_store = {
        type     = "S3"
        location = module.s3-codepipeline-artifacts.bucket_name
      }
      stages = [
        {
          name = "Source"
          actions = [{
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeStarSourceConnection"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "SourceVariables"
            output_artifacts = ["SourceArtifact"]
            input_artifacts  = []
            configuration = {
              BranchName           = "develop"
              ConnectionArn        = "arn:aws:codeconnections:ap-northeast-1:${local.aws_account}:connection/83fdeb97-c9d4-4a28-9c35-775c9498f156"
              DetectChanges        = "false"
              FullRepositoryId     = "nttdigital/internal-batch"
              OutputArtifactFormat = "CODE_ZIP"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        },
        {
          name = "Build"
          actions = [{
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "BuildVariables"
            output_artifacts = ["BuildArtifact"]
            input_artifacts  = ["SourceArtifact"]
            configuration = {
              ProjectName = "${local.name_prefix}-build-internal-batch-pj"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        },
        {
          name = "SnykScan"
          actions = [{
            name             = "SnykScan"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"
            version          = "1"
            run_order        = 1
            region           = "ap-northeast-1"
            namespace        = "${local.name_prefix}-internal-batch-snyk-scan"
            output_artifacts = []
            input_artifacts  = ["SourceArtifact"]
            configuration = {
              ProjectName = "${local.name_prefix}-build-snykscan-pj"
            }
          }]
          on_failure = {
            result = "RETRY"
            retry_configuration = {
              retry_mode = "ALL_ACTIONS"
            }
          }
        }
      ]
    }
  ]
}
