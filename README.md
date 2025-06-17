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
- Fedra Core OS
    - k3s のホスト OS として使用するコンテナランタイムを持つ OS

## クラスタ構成

- ノード `elysia-kevin`
    - Control Plane & Worker Node
- ノード `elysia-eden`
    - Control Plane & Worker Node
- ノード `elysia-eden`
    - Control Plane & Worker Node
- ノード `elysia-pardofelis`
    - Load Balancer Node (kube-vip)
- ノード  `elysia-su`
    - Worker Node

# セットアップ

1. `.env.example` を `.env` にコピーして編集 (R2のキー等をS3の形式に合わせて生成)
2. `terraform/modules/elysia/variables.tf.example` を `terraform/modules/elysia/variables.tf` にコピーして編集
