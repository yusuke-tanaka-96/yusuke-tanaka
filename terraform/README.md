# Terraform Code Readme

## 概要

このリポジトリは、AWSインフラ構築をTerraformで自動化するためのコードを提供します。主に以下のAWSリソースを構築します：

* VPC (Virtual Private Cloud)
* Subnet (Public, Private, Protect)
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* VPC Peering
* VPC Endpoints
* VPC Link
* ACL
* EC2 Instances
* Auto Scaling Group
* Launch Template
* Network Load Balancer (NLB)
* Key Pair
* ECS
* S3
* API Gateway
* Route 53
* Lambda
* IAM
* Cloudwath
* Aurora
* Step Fuctions
* Secrets Manager
* SSM
* Kinesis

## ディレクトリ構成

```
├── modules/
│   ├── api_gateway/
│   ├── aurora/
│   ├── cloudwatch/
│   ├── ec2/
│   ├── ecs/
│   ├── event_brigde/
│   ├── iam/
│   ├── kinesis/
│   ├── route53/
│   ├── s3/
│   ├── secerts_manager/
│   ├── step_fuctions/
│   └── vpc/
├── env/
│   └── dev/
│       └── apigateway.tf
│       └── backend.tf
│       └── iam_policy.tf
│       └── main.tf
│       └── nacl_rules.tf
│       └── securitygroup.tf
│       └── outputs.tf
│       └── userdata_mainnet.sh
│       └── userdata_testnet.sh
│       └── userdata_backend.sh
│       └── outputs.tf
│   └── test/
│       └── apigateway.tf
│       └── backend.tf
│       └── iam_policy.tf
│       └── main.tf
│       └── nacl_rules.tf
│       └── securitygroup.tf
│       └── outputs.tf
│       └── userdata_mainnet.sh
│       └── userdata_testnet.sh
│       └── userdata_backend.sh
│       └── outputs.tf
│   └── prd/
│       └── apigateway.tf
│       └── backend.tf
│       └── iam_policy.tf
│       └── main.tf
│       └── nacl_rules.tf
│       └── securitygroup.tf
│       └── outputs.tf
│       └── userdata_mainnet.sh
│       └── userdata_testnet.sh
│       └── userdata_backend.sh
│       └── outputs.tf
└── README.md
```

## 事前準備

このTerraformコードを使用する前に、以下の準備が必要です：

### 1. キーペアの作成

* AWS Management Console で新しいキーペアを作成します。
* キーペアの名前はプロジェクトと環境に応じて指定します。
* 例: `dev-key.pem`
* キーペアはローカルにダウンロードし、適切な場所に保存します。

### 2. S3 バケットの作成 (Terraform State 用)

* `terraform-state-bucket` という名前で S3 バケットを作成します。
* バケットは `ap-northeast-1` (東京リージョン) に配置します。
* バージョニングを有効にし、アクセスは IAM ポリシーで制限します。

### 3. Terraform 作業用のサーバー準備

* AWS EC2 インスタンス (Amazon Linux 2023) をセットアップ
* 以下のパッケージをインストール：

  * Terraform
  * AWS CLI
  * Git
* インスタンスに適切な IAM ロールをアタッチし、以下のポリシーを付与：

  * AmazonS3FullAccess (S3 バケットへのアクセス)
  * AmazonEC2FullAccess (EC2 インスタンス管理)
  * IAMFullAccess (IAM 操作)

## Terraform の初期化

1. リポジトリをクローン

```bash
git clone <リポジトリURL>
cd env/dev
```

2. Terraform を初期化

```bash
terraform fmt
terraform init
```

3. 新しいブランチを作成して、コードを編集

```bash
git  checkout main
git pull
git checkout -b feature/[ブランチ名]
```

4. Terraform Plan を実行

```bash
terraform plan
```

5. git push を実行

```bash
git push origin feature/[ブランチ名]
```

6. PR を作成

## PRルールについて

本リポジトリへのPRが増えてきていますのでルールを記載いたします。

- PR作成時、PRタイトルに`[test1]`など先頭に環境名をつけ、タイトル名全体も分かりやすいものに変えてください。
- サマリーを必ず書いてください。
  - 量が多い時は箇条書きで。誰が見てもぱっと見で何を追加して何を変更したのかが分かるようにしてください。
  - 詳細はplan内容やファイルを確認しますが、意図した変更かどうかを確認するためにも重要です。
- 自分の出したPRで `terraform apply` が成功したら自分でマージしてください。
  - `apply`完了後も`plan`差分に関係のないゴミファイルの削除や、コメントの入れ忘れや修正を行う事がよくあるからです。
- コミットは出来るだけ分けてください。
  - 複雑な時は全部書いてplanして確かめると思うので難しい場合もありますが、最低限ファイル単位で分けるようにしてください。
- 自分のPRのplanやapply結果が終わるのを見届けて、自分の変更以外の差分が出た場合は誰かに聞くようにしてください。
- PR出して終わりじゃないです。

こちらのPR 参考にしてください。
- https://github.com/nttdigital/infra-terraform/pull/381
- https://github.com/nttdigital/infra-terraform/pull/427

そして最後にお願いですが、PRが溜まり過ぎていますのでもし不要になったものがあれば削除をお願いいたします。

## 注意事項

* S3 バケット `terraform-state-bucket` の名前は変更できますが、`backend.tf` ファイルで同じ名前にする必要があります。
* EC2 インスタンスは AWS CLI または SSH クライアントからのアクセスを許可します。
