# Elysia Kubernetes Engine - Terraform Configuration

このディレクトリには、Proxmox VE上でElysia Kubernetes Engineクラスタを構築するためのTerraform設定が含まれています。

## クラスタ構成

以下の5つのVMが作成されます：

### Control Plane & Worker ノード
- **elysia-kevin** (10.42.0.10) - Control Plane & Worker Node (4 CPU, 4GB RAM, 50GB Disk)
- **elysia-eden** (10.42.0.11) - Control Plane & Worker Node (4 CPU, 4GB RAM, 50GB Disk)
- **elysia-mobius** (10.42.0.12) - Control Plane & Worker Node (4 CPU, 4GB RAM, 50GB Disk)

### Load Balancer ノード
- **elysia-pardofelis** (10.42.0.100) - Load Balancer (kube-vip) (2 CPU, 2GB RAM, 30GB Disk)

### Worker ノード
- **elysia-su** (10.42.0.20) - Worker Node (2 CPU, 3GB RAM, 40GB Disk)

## 使用前の設定

1. `variables.tf.example`を参考に、`variables.tf`に適切な値を設定してください：
   ```hcl
   variable "proxmox_config" {
     default = {
       endpoint     = "https://your-proxmox-host:8006"
       username     = "root@pam"
       password     = "your-proxmox-password"
       pub_key_file = "/path/to/your/public_key.pub"
     }
   }
   ```

2. 各Proxmoxノードが以下の名前で設定されていることを確認してください：
   - `kevin` - elysia-kevinが配置されるProxmoxノード
   - `eden` - elysia-edenが配置されるProxmoxノード
   - `mobius` - elysia-mobiusが配置されるProxmoxノード
   - `pardofelis` - elysia-pardofelisが配置されるProxmoxノード
   - `su` - elysia-suが配置されるProxmoxノード

## 実行方法

```bash
# Terraformの初期化
terraform init

# 実行計画の確認
terraform plan

# インフラストラクチャの作成
terraform apply

# インフラストラクチャの削除
terraform destroy
```

## 技術スタック

- **Proxmox VE**: ハイパーバイザー
- **Ubuntu 24.04 LTS**: ゲストOS（Cloud Image）
- **k3s**: 軽量Kubernetes
- **kube-vip**: 仮想IP提供、HA構成実現

## ネットワーク設定

- **ネットワーク**: 10.42.0.0/24
- **ゲートウェイ**: 10.42.0.1
- **ブリッジ**: br0

## 将来の拡張

- Fedora CoreOSへの移行（予定）
- Ansibleによる自動設定の追加
- マニフェスト管理の追加

## トラブルシューティング

### よくある問題

1. **VM作成が失敗する場合**
   - Proxmoxノード名が正しく設定されているか確認
   - ネットワーク設定（ブリッジbr0）が存在するか確認
   - ストレージ（local-lvm）が利用可能か確認

2. **SSH接続が失敗する場合**
   - 公開鍵のパスが正しいか確認
   - Proxmox VEのファイアウォール設定を確認

3. **イメージダウンロードが失敗する場合**
   - Proxmoxノードからインターネットにアクセスできるか確認

