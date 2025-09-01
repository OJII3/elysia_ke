# Elysia Kubernetes Engine

Proxmox VE 上で動かす、k3s クラスタの構築を支援するツールです。

## 使用するもの

- Proxmox VE (proxmox-nixos)
    - VM のハイパーバイザー
- terraform
    - インフラストラクチャのコード化ツール
- k3s
    - Kubernetes の軽量版
- kube-vip
    - Kubernetes クラスタの仮想 IP を提供するツール, HA 構成を実現
- Flatcar Container Linux
    - k3s のホスト OS として使用するコンテナランタイムを持つ OS

## クラスタ構成（3ノード HA）

- ノード `elysia-eden`
    - Control Plane & Worker Node & Load Balancer Node (kube-vip)
- ノード `elysia-mobius`
    - Control Plane & Worker Node
- ノード `elysia-pardofelis`
    - Control Plane & Worker Node

# セットアップ

1. `.env.example` を `.env` にコピーして編集 (R2のキー等をS3の形式に合わせて生成)
2. `terraform/modules/elysia/variables.tf.example` を `terraform/modules/elysia/variables.tf` にコピーして編集

```sh
qm create 9000 --name ubuntu-22.04-cloudinit-template --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 /var/lib/vz/template/iso/ubuntu-22.04-server-cloudimg-amd64.img local-lvm
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --ide2 local-lvm:cloudinit --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0 --agent 1
qm template 9000
```

## Perforce Helix Core (p4d) を k3s で動かす

このリポジトリは p4d をシングルレプリカでデプロイするための Kubernetes マニフェストを自動投入できます（NodePort 1666 で公開）。HA 構成やライセンス運用は各自の要件に合わせて調整してください。

有効化手順:

1. `terraform/elysia.auto.tfvars`（Git管理外）を作成し、以下を設定します。

   ```hcl
   p4d_config = {
     enabled      = true
     image        = "perforce/helix-core-server:latest" # 正しい公式イメージに置き換え推奨
     storage_size = "50Gi"                               # データ保持用PVC容量
     node_port    = 31666                                 # NodePort (TCP/1666)
   }
   ```

2. いつも通り `terraform plan` → `terraform apply`。

3. デプロイ後、`perforce` ネームスペースに `p4d` が起動します。
   - 接続先: `任意のノードIP:31666`（例: `192.168.8.10:31666`）
   - データ: `p4d-data` PVC に永続化（標準の StorageClass を利用）

注意事項:

- コンテナイメージの設定や初期管理者のプロビジョニングは、採用する公式イメージのドキュメントに合わせて調整してください（このリポジトリではプレースホルダのみ提供）。
- NodePort ではなく LoadBalancer を使いたい場合は、kube-vip の Service LB 構成を併用するか、MetalLB の導入を検討してください。
