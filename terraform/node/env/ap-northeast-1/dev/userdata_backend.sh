#!/bin/bash

set -euo pipefail

# userdataの実行ログ出力
exec > >(tee -a /var/log/user-data.log) 2>&1

# リトライするラッパ関数
retry() { n=0; until [ $n -ge 5 ]; do "$@" && break; n=$((n+1)); sleep 5; done }

# ネットワークとDNSが使えるまで待機
for i in {1..30}; do
  if curl -s --connect-timeout 5 https://checkip.amazonaws.com >/dev/null 2>&1; then
    echo "[OK] network ready"
    break
  fi
  echo "[WAIT] network not ready... ($i)"
  sleep 5
done

# パッケージ更新
retry dnf upgrade --releasever=2023.8.20250915 -y
retry dnf update -y

dnf install -y postgresql15

# --- Setup CloudWatch Agent ---
yum install -y amazon-cloudwatch-agent rsyslog
systemctl enable rsyslog
systemctl start rsyslog

cat <<EOT > /opt/aws/amazon-cloudwatch-agent/bin/config.json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/messages",
            "log_group_name": "/aws/ec2/test1-backend-bastion-messages-log",
            "log_stream_name": "{instance_id}-messages-log"
          },
          {
            "file_path": "/var/log/secure",
            "log_group_name": "/aws/ec2/test1-backend-bastion-secure-log",
            "log_stream_name": "{instance_id}-secure-log"
          },
          {
            "file_path": "/var/log/dnf.log",
            "log_group_name": "/aws/ec2/test1-backend-bastion-yum-log",
            "log_stream_name": "{instance_id}-yum-log"
          },
          {
            "file_path": "/root/.newrelic/newrelic-cli.log",
            "log_group_name": "/aws/ec2/test1-backend-bastion-newrelic-log",
            "log_stream_name": "{instance_id}-newrelic-log"
          },
          {
            "file_path": "/var/log/amazon/ssm/amazon-ssm-agent.log",
            "log_group_name": "/aws/ec2/test1-backend-bastion-ssm-agent-log",
            "log_stream_name": "{instance_id}-ssm-agent-log"
          },
          {
            "file_path": "/var/log/cloud-init.log",
            "log_group_name": "/aws/ec2/test1-backend-bastion-cloud-init-log",
            "log_stream_name": "{instance_id}-cloud-init-log"
          },
          {
            "file_path": "/opt/draios/logs/draios.log",
            "log_group_name": "/aws/ec2/test1-backend-bastion-sysdig-log",
            "log_stream_name": "{instance_id}-sysdig-log"
          }
        ]
      }
    }
  }
}
EOT

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
  -s

# ディスクへの書き込み完了を待つ
sync
sleep 3

reboot

# ⚠️再起動後、以下のコマンドを手動で実行してデフォルトのカーネルを削除してください
# デフォルトのカーネル（kernel-6.1.134-150.224.amzn2023.x86_64）は脆弱性チェックで検知されてしまいます
# sudo dnf remove --oldinstallonly -y
