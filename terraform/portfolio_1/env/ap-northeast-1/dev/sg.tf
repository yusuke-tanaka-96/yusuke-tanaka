
data "aws_security_group" "elb-backend-tenant-api" {
  name = "${local.name_prefix}-sg-elb-backend-tenant-api"
}
data "aws_security_group" "elb-testnet-pf1" {
  name = "${local.name_prefix}-sg-elb-testnet-pf1"
}
data "aws_security_group" "elb-testnet-pf2" {
  name = "${local.name_prefix}-sg-elb-testnet-pf2"
}

data "aws_security_group" "ecs-backend-tenant-api" {
  name = "${local.name_prefix}-sg-ecs-backend-tenant-api"
}

data "aws_security_group" "sg-ssh-bastion" {
  name = "${local.name_prefix}-sg-ssh-bastion"
}
data "aws_security_group" "sg-backend-auth-lambda" {
  name = "${local.name_prefix}-sg-backend-auth-lambda"
}
data "aws_security_group" "sg-db-backend" {
  name = "${local.name_prefix}-sg-db-backend"
}

locals {
  sysdig_https_cidrs = ["0.0.0.0/0"] # TODO: replace with SaaS CIDRs if/when published

  sg_backend_auth_lambda = [
    {
      name        = "${local.name_prefix}-sg-backend-auth-lambda"
      description = "lambda security group"
      ingress = [
        {
          description = "Allow HTTPS traffic"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-backend-prefix}.0.0/16"]
        }
      ]
      egress = [
        {
          description = "DNS UDP"
          from_port   = 53
          to_port     = 53
          protocol    = "udp"
          cidr_blocks = ["${local.vpc-backend-prefix}.0.0/16"]
        },
        {
          description = "DNS TCP"
          from_port   = 53
          to_port     = 53
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-backend-prefix}.0.0/16"]
        },
        {
          description = "Sysdig"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = local.sysdig_https_cidrs
        },
        {
          description     = "PostgreSQL"
          from_port       = 5432
          to_port         = 5432
          protocol        = "tcp"
          security_groups = [data.aws_security_group.sg-db-backend.id]
        }
      ]
    }
  ]


  sg_ssh_bastion = [
    {
      name        = "${local.name_prefix}-sg-ssh-bastion"
      description = "Allow ssh traffic from members"
      ingress = [

      ]
      egress = [
        {
          description = "Allow all outbound"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_vpc_peer_backend = [
    {
      name        = "${local.name_prefix}-sg-vpc-peer-backend"
      description = "Allow all traffic from inside"
      ingress = [
        {
          description = "Allow HTTPS traffic"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf1-prefix}.0.0/16", "${local.vpc-testnet-pf2-prefix}.0.0/16"]
        }
      ]
      egress = [
        {
          description = "Allow all outbound"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_elb_backend_tenant_api = [
    {
      name        = "${local.name_prefix}-sg-elb-backend-tenant-api"
      description = "Allow http traffic"
      ingress = [
        {
          description = "Allow https"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Allow http"
          from_port   = 280
          to_port     = 280
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress = [
        {
          description = "Allow all outbound"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_ecs_backend_tenant_api = [
    {
      name        = "${local.name_prefix}-sg-ecs-backend-tenant-api"
      description = "Allow http traffic"
      ingress = [
        {
          description = "Allow http 80"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          # cidr_blocks = ["${local.vpc-backend-prefix}.0.0/16"]
          security_groups = [data.aws_security_group.elb-backend-tenant-api.id]
        },
        {
          description = "Allow http 8080"
          from_port   = 8080
          to_port     = 8080
          protocol    = "tcp"
          # cidr_blocks = ["${local.vpc-backend-prefix}.0.0/16"]
          security_groups = [data.aws_security_group.elb-backend-tenant-api.id]
        }
      ]
      egress = [
        {
          description = "DNS UDP"
          from_port   = 53
          to_port     = 53
          protocol    = "udp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "DNSTCP"
          from_port   = 53
          to_port     = 53
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Sysdig"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = local.sysdig_https_cidrs
        },
        {
          description     = "PostgreSQL to Aurora"
          from_port       = 5432
          to_port         = 5432
          protocol        = "tcp"
          security_groups = [data.aws_security_group.sg-db-backend.id]
        },
        {
          description = "HTTP"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_endpoint_backend = [
    {
      name        = "${local.name_prefix}-sg-endpoint-backend"
      description = "Allow http traffic"
      ingress = [
        {
          description = "Allow HTTPS"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-backend-prefix}.0.0/16"]
          # security_groups = [data.aws_security_group.ecs-backend-tenant-api.id,
          # data.aws_security_group.ecs-backend-internal-api.id]
        }
      ]
      egress = [
        {
          description = "Allow all outbound"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_db_backend = [
    {
      name        = "${local.name_prefix}-sg-db-backend"
      description = "Security Group for Aurora DB"
      ingress = [
        {
          description = "Allow PostgreSQL"
          from_port   = 5432
          to_port     = 5432
          protocol    = "tcp"
          # cidr_blocks = ["${local.vpc-backend-prefix}.0.0/16"]
          security_groups = [
            data.aws_security_group.ecs-backend-tenant-api.id,
            data.aws_security_group.ecs-backend-internal-api.id,
            data.aws_security_group.sg-ssh-bastion.id,
            data.aws_security_group.sg-backend-auth-lambda.id
          ]
        }
      ]
      egress = [
        {
          description = "Allow all outbound"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_elb_testnet_pf1 = [
    {
      name        = "${local.name_prefix}-sg-elb-testnet-pf1"
      description = "Allow http traffic"
      ingress = [
        {
          description = "Allow http"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-backend-prefix}.0.0/16", "${local.vpc-testnet-pf1-prefix}.0.0/16"]
        }
      ]
      egress = [
        {
          description = "Allow all outbound"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_elb_testnet_pf2 = [
    {
      name        = "${local.name_prefix}-sg-elb-testnet-pf2"
      description = "Allow http traffic"
      ingress = [
        {
          description = "Allow http"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-backend-prefix}.0.0/16", "${local.vpc-testnet-pf2-prefix}.0.0/16"]
        }
      ]
      egress = [
        {
          description = "Allow all outbound"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_ec2_testnet_pf1 = [
    {
      name        = "${local.name_prefix}-sg-ec2-testnet-pf1"
      description = "Allow http traffic"
      ingress = [
        {
          description     = "Allow ssh"
          from_port       = 22
          to_port         = 22
          protocol        = "tcp"
          security_groups = [data.aws_security_group.sg-ssh-bastion.id]
        },
        {
          description     = "Allow http"
          from_port       = 80
          to_port         = 80
          protocol        = "tcp"
          security_groups = [data.aws_security_group.elb-testnet-pf1.id]
        },
        {
          description     = "Allow https"
          from_port       = 443
          to_port         = 443
          protocol        = "tcp"
          security_groups = [data.aws_security_group.elb-testnet-pf1.id]
        }
      ]
      egress = [
        {
          description = "Allow DNS (UDP 53)"
          from_port   = 53
          to_port     = 53
          protocol    = "udp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Ext API S3"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Allow http to run userdata get AWS Token"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Allow TCP 1024-65535 for P2P connections"
          from_port   = 1024
          to_port     = 65535
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Allow UDP 1024-65535 for P2P connections"
          from_port   = 1024
          to_port     = 65535
          protocol    = "udp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_ec2_testnet_pf2 = [
    {
      name        = "${local.name_prefix}-sg-ec2-testnet-pf2"
      description = "Allow http traffic"
      ingress = [
        {
          description     = "Allow ssh"
          from_port       = 22
          to_port         = 22
          protocol        = "tcp"
          security_groups = [data.aws_security_group.sg-ssh-bastion.id]
        },
        {
          description     = "Allow http"
          from_port       = 80
          to_port         = 80
          protocol        = "tcp"
          security_groups = [data.aws_security_group.elb-testnet-pf2.id]
        },
        {
          description     = "Allow https"
          from_port       = 443
          to_port         = 443
          protocol        = "tcp"
          security_groups = [data.aws_security_group.elb-testnet-pf2.id]
        }
      ]
      egress = [
        {
          description = "Allow DNS (UDP 53)"
          from_port   = 53
          to_port     = 53
          protocol    = "udp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Ext API S3"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Allow http to run userdata get AWS Token"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Allow TCP 1024-65535 for P2P connections"
          from_port   = 1024
          to_port     = 65535
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Allow UDP 1024-65535 for P2P connections"
          from_port   = 1024
          to_port     = 65535
          protocol    = "udp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_endpoint_testnet_pf1 = [
    {
      name        = "${local.name_prefix}-sg-endpoint-testnet-pf1"
      description = "Allow http traffic"
      ingress = [
        {
          description = "Allow HTTPS"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf1-prefix}.111.0/24"]
        },
        {
          description = "Allow HTTPS"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf1-prefix}.112.0/24"]
        },
        {
          description = "Allow HTTPS"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf1-prefix}.113.0/24"]
        },
        {
          description = "private link"
          from_port   = 9997
          to_port     = 9997
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf1-prefix}.111.0/24"]
        },
        {
          description = "private link"
          from_port   = 9997
          to_port     = 9997
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf1-prefix}.112.0/24"]
        },
        {
          description = "private link"
          from_port   = 9997
          to_port     = 9997
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf1-prefix}.113.0/24"]
        }
      ]
      egress = [
        {
          description = "Allow all outbound"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_endpoint_testnet_pf2 = [
    {
      name        = "${local.name_prefix}-sg-endpoint-testnet-pf2"
      description = "Allow http traffic"
      ingress = [
        {
          description = "Allow HTTPS"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf2-prefix}.111.0/24"]
        },
        {
          description = "Allow HTTPS"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf2-prefix}.112.0/24"]
        },
        {
          description = "Allow HTTPS"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf2-prefix}.113.0/24"]
        },
        {
          description = "private link"
          from_port   = 9997
          to_port     = 9997
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf2-prefix}.111.0/24"]
        },
        {
          description = "private link"
          from_port   = 9997
          to_port     = 9997
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf2-prefix}.112.0/24"]
        },
        {
          description = "private link"
          from_port   = 9997
          to_port     = 9997
          protocol    = "tcp"
          cidr_blocks = ["${local.vpc-testnet-pf2-prefix}.113.0/24"]
        }
      ]
      egress = [
        {
          description = "Allow all outbound"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  sg_endpoint_custom_ami = [
    {
      name        = "${local.name_prefix}-sg-endpoint-custom-ami"
      description = "Allow http traffic"
      ingress     = []
      egress = [
        {
          description = "Allow all outbound"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]


  backend_security_groups = concat(local.sg_elb_backend_tenant_api, local.sg_ecs_backend_tenant_api, local.sg_endpoint_backend,
  local.sg_db_backend, local.sg_vpc_peer_backend, local.sg_ssh_bastion, local.sg_backend_auth_lambda)
  testnet_pf1_security_groups = concat(local.sg_elb_testnet_pf1, local.sg_ec2_testnet_pf1, local.sg_endpoint_testnet_pf1)
  testnet_pf2_security_groups = concat(local.sg_elb_testnet_pf2, local.sg_ec2_testnet_pf2, local.sg_endpoint_testnet_pf2)
}
