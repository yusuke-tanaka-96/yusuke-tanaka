locals {
  nacl_rules_backend = [
    {
      name        = "${local.name_prefix}-nacl-public-backend"
      description = "NACL for Public Subnet"
      subnet_ids  = module.vpc-backend.public_subnet_ids
      ingress = [
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 120
          protocol    = "udp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 300
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = module.vpc-backend.public_subnet_cidrs[0]
          rule_action = "allow"
        },
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        },
      ]
      egress = [
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 110
          protocol    = "udp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 300
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = module.vpc-backend.public_subnet_cidrs[0]
          rule_action = "allow"
        },
        {
          rule_number = 400
          protocol    = "tcp"
          from_port   = 22
          to_port     = 22
          cidr_block  = module.vpc-testnet-pf1.vpc_cidr
          rule_action = "allow"
        },
        {
          rule_number = 410
          protocol    = "tcp"
          from_port   = 22
          to_port     = 22
          cidr_block  = module.vpc-testnet-pf2.vpc_cidr
          rule_action = "allow"
        },
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
    },
    {
      name        = "${local.name_prefix}-nacl-private-backend-tenant-api"
      description = "NACL for Private Subnet"
      subnet_ids  = [module.vpc-backend.private_subnet_ids[0], module.vpc-backend.private_subnet_ids[1]]
      ingress = [
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
      egress = [
        # sysdig用
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # dbへ接続用
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 5432
          to_port     = 5432
          cidr_block  = module.vpc-backend.protect_subnet_cidrs[0]
          rule_action = "allow"
        },
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 5432
          to_port     = 5432
          cidr_block  = module.vpc-backend.protect_subnet_cidrs[1]
          rule_action = "allow"
        },
        # 上記以外の場合、拒否
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
    },
    {
      name        = "${local.name_prefix}-nacl-protect-backend"
      description = "NACL for Protect Subnet"
      subnet_ids  = module.vpc-backend.protect_subnet_ids
      ingress = [
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 5432
          to_port     = 5432
          cidr_block  = module.vpc-backend.private_subnet_cidrs[0]
          rule_action = "allow"
        },
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 5432
          to_port     = 5432
          cidr_block  = module.vpc-backend.private_subnet_cidrs[1]
          rule_action = "allow"
        },
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 5432
          to_port     = 5432
          cidr_block  = module.vpc-backend.private_subnet_cidrs[2]
          rule_action = "allow"
        },
        {
          rule_number = 130
          protocol    = "tcp"
          from_port   = 5432
          to_port     = 5432
          cidr_block  = module.vpc-backend.private_subnet_cidrs[3]
          rule_action = "allow"
        },
        {
          rule_number = 140
          protocol    = "tcp"
          from_port   = 5432
          to_port     = 5432
          cidr_block  = module.vpc-backend.public_subnet_cidrs[0]
          rule_action = "allow"
        },
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
      egress = [
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = module.vpc-backend.private_subnet_cidrs[0]
          rule_action = "allow"
        },
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = module.vpc-backend.private_subnet_cidrs[1]
          rule_action = "allow"
        },
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = module.vpc-backend.private_subnet_cidrs[2]
          rule_action = "allow"
        },
        {
          rule_number = 130
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = module.vpc-backend.private_subnet_cidrs[3]
          rule_action = "allow"
        },
        {
          rule_number = 140
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = module.vpc-backend.public_subnet_cidrs[0]
          rule_action = "allow"
        },
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        },
      ]
    }
  ]

  nacl_rules_testnet_pf1 = [
    {
      name        = "${local.name_prefix}-nacl-public-testnet-pf1"
      description = "NACL for Public Subnet"
      subnet_ids  = module.vpc-testnet-pf1.public_subnet_ids
      ingress = [
        # 内部からのhttp(s) アクセスを許可
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = "${local.vpc-testnet-pf1-prefix}.0.0/16"
          rule_action = "allow"
        },
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 80
          to_port     = 80
          cidr_block  = "${local.vpc-testnet-pf1-prefix}.0.0/16"
          rule_action = "allow"
        },
        # p2p用に広い範囲の Ephemeral Portを許可
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 130
          protocol    = "udp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # 上記以外を拒否
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
      egress = [
        # 内部からのhttp(s) アクセスを許可
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 80
          to_port     = 80
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # p2p用に広い範囲の Ephemeral Portを許可
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 130
          protocol    = "udp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # 上記以外を拒否
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
    },
    {
      name        = "${local.name_prefix}-nacl-private-testnet-pf1"
      description = "NACL for Private Subnet"
      subnet_ids  = module.vpc-testnet-pf1.private_subnet_ids
      ingress = [
        # P2P 通信（Bitcoin）: **注意**ネットワークによりPortが違う(Mainnet: 8333, Testnet: 18333)
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 18333
          to_port     = 18333
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # UbuntuのEphemeral port範囲: aptなどの戻り通信用
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 32768
          to_port     = 60999
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # 内部通信用
        {
          rule_number = 300
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "${local.vpc-testnet-pf1-prefix}.0.0/16"
          rule_action = "allow"
        },
        # BastionからのSSHアクセスを必要な時に許可用
        {
          rule_number = 310
          protocol    = "tcp"
          from_port   = 22
          to_port     = 22
          cidr_block  = module.vpc-backend.public_subnet_cidrs[0]
          rule_action = "deny"
        },
        # Backend > NLB(443) > Node の許可
        {
          rule_number = 400
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = module.vpc-backend.private_subnet_cidrs[0]
          rule_action = "allow"
        },
        {
          rule_number = 410
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = module.vpc-backend.private_subnet_cidrs[1]
          rule_action = "allow"
        },
        {
          rule_number = 500
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # 上記以外全部deny
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
      egress = [
        # aptなど更新作用
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 80
          to_port     = 80
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # P2P通信用宛先Port、全開するのもいいが、Ephemeral Port範囲にしておく(Well-known PortでP2P通信しているpeerは捨てる)
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 130
          protocol    = "udp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # 内部通信通信用
        {
          rule_number = 300
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "${local.vpc-testnet-pf1-prefix}.0.0/16"
          rule_action = "allow"
        },
        # 上記以外全部deny
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
    }
  ]

  nacl_rules_testnet_pf2 = [
    {
      name        = "${local.name_prefix}-nacl-public-testnet-pf2"
      description = "NACL for Public Subnet"
      subnet_ids  = module.vpc-testnet-pf2.public_subnet_ids
      ingress = [
        # 内部からのhttp(s) アクセスを許可
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = "${local.vpc-testnet-pf2-prefix}.0.0/16"
          rule_action = "allow"
        },
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 80
          to_port     = 80
          cidr_block  = "${local.vpc-testnet-pf2-prefix}.0.0/16"
          rule_action = "allow"
        },
        # p2p用に広い範囲の Ephemeral Portを許可
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 130
          protocol    = "udp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # 上記以外を拒否
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
      egress = [
        # 内部からのhttp(s) アクセスを許可
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 80
          to_port     = 80
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # p2p用に広い範囲の Ephemeral Portを許可
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 130
          protocol    = "udp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # 上記以外を拒否
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
    },
    {
      name        = "${local.name_prefix}-nacl-private-testnet-pf2"
      description = "NACL for Private Subnet"
      subnet_ids  = module.vpc-testnet-pf2.private_subnet_ids
      ingress = [
        # LibP2P（Beacon）: 他ノードとのP2P通信
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 13000
          to_port     = 13000
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # LibP2P（Discovery）: 他ノードとのピア発見
        {
          rule_number = 110
          protocol    = "udp"
          from_port   = 12000
          to_port     = 12000
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # Erigon P2P: 他ノードとのブロック・トランザクション交換
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 30303
          to_port     = 30303
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 130
          protocol    = "udp"
          from_port   = 30303
          to_port     = 30303
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # UbuntuのEphemeral port範囲: aptなどの戻り通信用
        {
          rule_number = 140
          protocol    = "tcp"
          from_port   = 32768
          to_port     = 60999
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # 内部通信用
        {
          rule_number = 300
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "${local.vpc-testnet-pf2-prefix}.0.0/16"
          rule_action = "allow"
        },
        # BastionからのSSHアクセスを必要な時に許可用
        {
          rule_number = 310
          protocol    = "tcp"
          from_port   = 22
          to_port     = 22
          cidr_block  = module.vpc-backend.public_subnet_cidrs[0]
          rule_action = "deny"
        },
        # Backend > NLB(443) > Node の許可
        {
          rule_number = 400
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = module.vpc-backend.private_subnet_cidrs[0]
          rule_action = "allow"
        },
        {
          rule_number = 410
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = module.vpc-backend.private_subnet_cidrs[1]
          rule_action = "allow"
        },
        # 外形監視(lambda)用 Ephemeral Portの戻り通信
        {
          rule_number = 500
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # 上記以外全部deny
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
      egress = [
        # aptなど更新作用
        {
          rule_number = 100
          protocol    = "tcp"
          from_port   = 443
          to_port     = 443
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 110
          protocol    = "tcp"
          from_port   = 80
          to_port     = 80
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # P2P通信用宛先Port、全開するのもいいが、Ephemeral Port範囲にしておく(Well-known PortでP2P通信しているpeerは捨てる)
        {
          rule_number = 120
          protocol    = "tcp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        {
          rule_number = 130
          protocol    = "udp"
          from_port   = 1024
          to_port     = 65535
          cidr_block  = "0.0.0.0/0"
          rule_action = "allow"
        },
        # 内部通信通信用(消せそうだが、害にならなので残しておく)
        {
          rule_number = 300
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "${local.vpc-testnet-pf2-prefix}.0.0/16"
          rule_action = "allow"
        },
        # 上記以外全部deny
        {
          rule_number = 32766
          protocol    = "-1"
          from_port   = 0
          to_port     = 0
          cidr_block  = "0.0.0.0/0"
          rule_action = "deny"
        }
      ]
    }
  ]
}
