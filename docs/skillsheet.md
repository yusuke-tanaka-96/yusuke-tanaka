# スキルシート

## 基本情報

| 項目 | 内容 |
| ---- | ---- |
| 氏名 | 田中 雄介（たなか ゆうすけ） |
| 年齢 | 29歳 |
| 居住地 | 東京都世田谷区 |
| 稼働形態 | フルリモート希望 |
| 稼働可能時間 | 月最大160h程度（週5・平日1日8h まで対応可）／ 状況に応じて減も相談可 |
| 稼働開始可能時期 | 即日可 |
| 希望単価 | 応相談 |
| 保有資格 | AWS Certified Solutions Architect – Associate (SAA) |
| 学歴 | 大学卒 |

## 自己PR

AWSを中心としたクラウドインフラの設計・構築・運用を専門とするインフラエンジニアです。Terraformによるマルチアカウント・5環境のIaC開発と、最大6名のインフラチームリーダーとしてAWSインフラ構築PJを約7ヶ月で本番リリースまで牽引した経験を強みとしています。

直近ではClaude Codeを活用したAI駆動開発に従事し、「コードを書く人」から「設計判断・品質担保・顧客折衝で価値を出す人」への役割シフトを進めています。インフラ領域に留まらず、アプリケーション設計（DDD・会計ドメイン・権限設計）まで対応範囲を拡大中です。

IT業界転向前は建設資材商社で約2年半、法人営業（官公庁入札・メーカー交渉・納期調整）に従事しており、顧客・協力会社・社内チームの間に立って合意形成を行う調整力も持ち合わせています。

## 得意分野・強み

- **AWSアーキテクチャ設計**：Multi-AZ・Multi-VPC・マルチアカウント構成の0からの設計（draw.io）、非機能要件（SLA・性能）を満たす構成検討、コスト見積もり・最適化提案
- **Terraformによる大規模IaC開発**：モジュール45種類以上・5環境×マルチVPC・環境あたり9,600行超のコード設計と運用
- **チームリーダーシップ**：自身より技術力の高いメンバーを含む6名チームの牽引、コード規約・命名規則・フォルダ構成の策定、タスク配分・技術的意思決定・顧客折衝
- **ゼロトラスト/セキュリティ設計**：VPC間最小権限制御、Private CA/ACM証明書管理、IAMポリシー厳格設計
- **顧客折衝**：技術知見の深い顧客・コンサル出身DevPMに対し、設計根拠をConfluenceに文書化して論理的に提案するスタイル
- **AI駆動開発**：Claude Codeを用いたインフラ設計書・要件定義書のレビュー・品質担保、AIで量産される成果物のドメインオーナーとしての最終責任

## テクニカルスキル

### レベル凡例
- ◎：後進指導・リード可能 / 設計から構築まで独力で完遂可能
- ○：独力で実装・対応可能
- △：指示があれば対応可能 / 経験あり

### クラウド

| 技術 | 経験年数 | レベル | 備考 |
| ---- | ---- | ---- | ---- |
| AWS | 約2年 | ◎ | 設計〜構築〜運用引き継ぎ。40以上のサービスを実務で使用 |
| Azure | 約8ヶ月 | △ | 結合テスト・基盤構築支援フェーズで参画 |

**AWS 主要利用サービス**：VPC、EC2、ECS Fargate（Graviton含む）、Aurora PostgreSQL（Multi-AZ）、ElastiCache Valkey、Redshift（Zero-ETL）、Lambda、API Gateway、ALB、NLB、CloudFront、Route53、WAF、S3、SNS/SQS、KMS、Secrets Manager、IAM、ACM、Private CA、Step Functions、Kinesis Data Firehose、CodePipeline/CodeBuild/CodeDeploy、CloudWatch

### IaC・構成管理

| 技術 | 経験年数 | レベル | 備考 |
| ---- | ---- | ---- | ---- |
| Terraform | 約2年 | ◎ | モジュール設計・命名規則策定、5環境×マルチVPCの大規模構築 |
| Ansible | 約1年 | ○ | OS別Playbook作成（AL2023/Rocky/RHEL9）、ミドルウェア・DB導入 |

### OS

| 技術 | 経験年数 | レベル | 備考 |
| ---- | ---- | ---- | ---- |
| Linux（RHEL、Rocky、Ubuntu、AL2023） | 約2年半 | ○ | サーバ構築・運用、シェル実装 |
| Windows Server | 約半年 | △ | 官公庁向けDaaS構築で使用 |

### 監視

| 技術 | 経験年数 | レベル | 備考 |
| ---- | ---- | ---- | ---- |
| CloudWatch | 約2年 | ○ | ダッシュボード作成、アラーム設計 |
| New Relic | 約7ヶ月 | ○ | Kinesis Firehose連携、監視基盤構築 |
| Sysdig | 約7ヶ月 | △ | APM・セキュリティ監視 |
| Grafana | 約1年 | ○ | リソース監視ダッシュボード |
| Zabbix | 約1年 | ○ | サーバ監視、基本設計書作成 |

### DB・ミドルウェア

| 技術 | 経験年数 | レベル | 備考 |
| ---- | ---- | ---- | ---- |
| PostgreSQL | 約2年 | ○ | Aurora PostgreSQL、運用 |
| pgpool | 約1年 | ○ | フェイルオーバー時のDNS書き換え自動化、運用手順書整備 |
| Pacemaker / DRBD | 約1ヶ月 | △ | クラスタ構築（Azure） |
| LifeKeeper | 約1ヶ月 | △ | 導入・設定（VMware） |
| ClusterPRO | 約1ヶ月 | △ | 基本設計書作成 |

### 言語・スクリプト

| 技術 | 経験年数 | レベル | 備考 |
| ---- | ---- | ---- | ---- |
| ShellScript | 約1年 | ○ | tfstateファイル自動移行、ACM証明書発行自動化、pgpool運用ツール |
| Python | 約1年 | ○ | Lambda実装（CloudWatchアラームトリガー、Authorizer等） |

### CI/CD

| 技術 | 経験年数 | レベル | 備考 |
| ---- | ---- | ---- | ---- |
| GitHub Actions | 約2年 | ○ | OIDC認証によるTerraform Plan/Apply自動化 |
| CodePipeline / CodeBuild / CodeDeploy | 約7ヶ月 | ○ | デプロイパイプライン構築 |

### 仮想化

| 技術 | 経験年数 | レベル | 備考 |
| ---- | ---- | ---- | ---- |
| VMware | 約1ヶ月 | △ | 仮想サーバ払出、vSwitch/ポートグループ設定 |

### AI開発ツール

| 技術 | 経験年数 | レベル | 備考 |
| ---- | ---- | ---- | ---- |
| Claude Code | 約7ヶ月 | ◎ | AI駆動開発の実務推進、設計書/仕様書のレビュー・品質担保 |
| Cursor | 約7ヶ月 | ○ | コーディング支援 |

### ドキュメンテーション・その他ツール

| 技術 | レベル | 備考 |
| ---- | ---- | ---- |
| draw.io | ◎ | インフラ構成図・ネットワーク図作成（0から設計） |
| Confluence | ○ | 設計ドキュメント・提案資料 |
| GitHub | ○ | コード管理、PRレビュー |
| Jira / Redmine / Backlog | ○ | タスク管理 |

## 担当可能工程

| 工程 | レベル | 備考 |
| ---- | ---- | ---- |
| 要件定義 | ○ | web3ノードサービス、美容室基幹システムで担当 |
| 基本設計 | ◎ | インフラアーキ設計・ネットワーク設計・構成図作成 |
| 詳細設計 | ◎ | Terraformモジュール設計、IAM/SG/NACL設計 |
| 構築・実装 | ◎ | Terraform/Ansibleによる構築、Lambda実装、シェル実装 |
| 単体・結合テスト | ○ | 検証環境での動作確認、本番EC2での検証 |
| 運用・保守 | ○ | 監視基盤構築、運用手順書整備 |
| 運用引き継ぎ | ◎ | 運用チームへのナレッジ共有・引き継ぎ完遂経験 |
| プロジェクト管理（リーダー業務） | ○ | 最大6名のチームマネジメント、タスク配分、顧客折衝 |

## プロジェクト経歴

### No.1 大手美容室チェーン 基幹システム構築（2025年10月〜現在）

| 項目 | 内容 |
| ---- | ---- |
| 業種 | 美容（マルチテナント型SaaS） |
| 役割 | ドメインオーナー（インフラ・会計・権限） |
| 規模 | 数百店舗規模・約100社のオーナー企業を想定 |
| フェーズ | 要件定義・基本設計（2026年3月より開発フェーズ移行予定） |
| 工程 | 要件定義 / 基本設計 / アーキテクチャ設計 / ドキュメント整備 |

**担当業務**
- AWSインフラアーキテクチャの設計、およびインフラ構成図をdraw.ioで自ら0から作成
- AWS運用コストの見積もり・最適化提案（月額約32万円算出、Graviton採用等）
- 会計ドメインのオーナーとして仕様書・ドメインモデルのレビュー・改善（69ユースケース・75以上のAPI）
- 全ドメイン横断（28バウンデッドコンテキスト）の権限設計のオーナーシップ
- 要件定義書・ビジネスルール・用語集等のドキュメント整備（GitHub管理、CloudFront配信）
- AI生成ドキュメントのレビュー・品質担保、顧客調整・技術窓口

**使用技術**：AWS（ECS Fargate / Aurora PostgreSQL Multi-AZ / ElastiCache Valkey / Redshift Zero-ETL / Lambda / CloudFront / ALB / WAF / Route53 / S3 / SNS/SQS / KMS / Secrets Manager）、Terraform（予定）、Claude Code、draw.io、GitHub

---

### No.2 エンタープライズ向けweb3ノードサービス構築（2025年4月〜2025年10月）

| 項目 | 内容 |
| ---- | ---- |
| 業種 | ブロックチェーン（マネージドサービス） |
| 役割 | インフラチームリーダー（組織50名、インフラチーム最大6名） |
| 規模 | 5環境（dev/test1/test2/prod1/prod2）×マルチVPC（バックエンド+BTC+ETH） |
| フェーズ | 要件定義〜本番リリース〜運用引き継ぎ（約7ヶ月で完遂） |
| 工程 | 要件定義 / 基本設計 / 詳細設計 / 構築 / テスト / 運用引き継ぎ |

**担当業務**
- インフラチームリーダーとして最大6名のマネジメント・タスク配分
- 顧客およびDevPM・他チーム（バックエンド・ブロックチェーン・テスト）との技術折衝
- サービス要件定義・システム要件定義作成、ブループリント類作成（インフラ・実行アーキテクチャ・DevOps）
- インフラ構成図・ネットワーク図をdraw.ioで自ら作成
- AWSリソースのTerraformによる構築（モジュール45種類、環境あたり9,600行超）
- API Gateway（REST API・VPC Link）、WAF、Lambda 3本、New Relic監視基盤、Route53等の主要コンポーネントを自ら構築
- 運用チームへのナレッジ共有・引き継ぎ

**主な成果**
- Terraformコード規約・命名規則・フォルダ構成を自ら策定し、チーム開発基盤を整備
- 顧客（技術知見深い担当者・コンサル出身DevPM）から厚い信頼を獲得
- ゼロトラスト基盤のセキュリティ・冗長性設計（Private CA/ACM、IAM厳格設計、Multi-AZ）
- 5環境×マルチVPCの同時並行構築を予定通り完遂

**使用技術**：AWS（VPC / EC2 / ECS Fargate / Aurora PostgreSQL / Lambda / API Gateway / NLB / S3 / CloudFront / Route53 / KMS / Secrets Manager / CodePipeline・CodeBuild・CodeDeploy / CloudWatch / IAM / ACM / Private CA / Step Functions / Kinesis Data Firehose）、Terraform、GitHub Actions（OIDC）、New Relic、Sysdig、Confluence、draw.io、Linux

---

### No.3 FA機器総合メーカー各種WebシステムのAWSクラウド移行（2024年4月〜2025年3月）

| 項目 | 内容 |
| ---- | ---- |
| 業種 | FA機器製造業 |
| 役割 | メンバー（チーム9名→6名） |
| 規模 | EC2 140台（Live 100台＋Dev/Stg 40台）、DNS 262ホストゾーン |
| フェーズ | Lift&Shift移行（構築〜運用） |
| 工程 | 詳細設計 / 構築 / テスト / 運用 |

**担当業務**
- Terraformコードの実装・改修（EC2、IAM、VPC、SG、ALB、Route53、CloudWatch、S3、Kinesis、Firehose等）
- Terraform管理外リソースのimport
- Ansible Playbook作成（OS別：AL2023、Rocky、RHEL9）
- **262ホストゾーンの別AWSアカウントへの移行をシェルスクリプトで自動化（自ら提案・実行）**
- Lambda（Python）によるドメインフェイルオーバー機能の改修・テスト
- ACM証明書発行自動化ツールの実装（ShellScript）
- pgpoolフェイルオーバー時の別アカウントDNSルーティング先IPを動的に書き換えるシェル実装・本番EC2検証
- pgpool運用手順書の改修
- CloudWatch / Grafana / Zabbixによるリソース監視

**使用技術**：AWS（EC2 / IAM / VPC / ALB / Route53 / CloudWatch / S3 / Lambda / ACM / Kinesis / Firehose）、Terraform、Ansible、GitHub Actions、Linux（AL2023/Rocky/RHEL9）、Python、ShellScript、Grafana、Zabbix、PostgreSQL、pgpool

---

### No.4 官公庁向けサーバ構築（2023年10月〜2024年3月）

| 項目 | 内容 |
| ---- | ---- |
| 業種 | 官公庁 |
| 役割 | メンバー（全体：数百名規模、チーム24名→8名） |
| 規模 | DaaS環境（仮想サーバ1,000台以上） |
| 工程 | 構築 / 単体・結合テスト |

**担当業務**：業務用ソフトウェアのインストール・サーバ設定、手順書作成・改修、単体・結合テスト

**使用技術**：Azure、Linux、Windows Server

---

### No.5 官公庁向け仮想基盤環境の設計・構築（2023年9月）

| 項目 | 内容 |
| ---- | ---- |
| 業種 | 官公庁 |
| 役割 | メンバー（社内受託、チーム5名） |
| 規模 | 仮想基盤環境（数百台規模）の更改、検証環境用仮想サーバ58台 |
| 工程 | 基本設計 / 構築 |

**担当業務**：VMwareでの仮想サーバ払出、基本設計書作成（ClusterPRO、Zabbix）、LifeKeeper導入・設定、ネットワーク構築（vSwitch、ポートグループ）

**使用技術**：VMware、ClusterPRO、Zabbix、LifeKeeper

---

### No.6 独立行政法人向けAzure基盤構築支援（2023年8月）

| 項目 | 内容 |
| ---- | ---- |
| 業種 | 独立行政法人 |
| 役割 | メンバー（社内受託、チーム10名、スポット参画） |
| 規模 | 本番63台、検証20台 |
| 工程 | 結合テスト |

**担当業務**：NFSサーバ構築、Pacemaker/DRBDによるクラスタ構築、OSイメージ作成（Ubuntu、RHEL8・9）、結合テスト

**使用技術**：Azure、Linux（Ubuntu / RHEL 8・9）、Pacemaker、DRBD、NFS

---

## IT業界転向前の経験（参考）

岡三リビック株式会社（2019/04〜2021/09）にて建設資材専門商社で法人営業を担当。民間・官公庁向けの新規開拓営業、既存顧客営業、メーカー交渉、商材の納入手配を経験。官公庁入札や納期調整の場面で、顧客・メーカー・施工会社の間に立って動いた経験は、現職でのチームリーダー業務やチーム横断の顧客調整でも活きています。
