# Repository Guidelines

This repository provisions a k3s cluster on Proxmox VE using Terraform, with a Nix flake dev environment and direnv for shell setup. Follow the practices below to keep changes consistent and safe.

## Project Structure & Module Organization
- `terraform/`: Root Terraform entry (`main.tf`) and backend config (`terraform.tf`).
- `terraform/modules/elysia/`: Module defining VMs, cloud-init templates under `cloud-init/`.
- `flake.nix`: Nix dev shell (Terraform and Proxmox provider).
- `.env.example` → `.env`: S3/R2 credentials; loaded via direnv. Do not commit `.env`.

## Build, Test, and Development Commands
- `direnv allow`: Enable the flake dev shell and load `.env`.
- `nix develop`: Enter dev shell (if not using direnv).
- `cd terraform && terraform init`: Initialize providers and remote state backend.
- `terraform validate`: Static validation of Terraform configuration.
- `terraform plan`: Show proposed changes (use to review in PRs).
- `terraform apply`: Apply changes to Proxmox; use cautiously and prefer after review.

## Coding Style & Naming Conventions
- HCL style: 2-space indent, one block per concern; run `terraform fmt -recursive` before committing.
- Resource naming: Prefix cluster resources with `elysia_` (e.g., `elysia_eden`, `elysia_kevin`).
- Variables: Keep module inputs in `variables.tf` (copy from `variables.tf.example`); use `proxmox_config` and `k3s_config` shapes.
- Files: Keep cloud-init under `modules/elysia/cloud-init/`; use `.tf` for Terraform and `.yml` for cloud-init templates.

## Testing Guidelines
- Validation: `terraform validate` must pass.
- Planning: Attach `terraform plan` output (or summary) to PRs. Avoid `apply` from feature branches.
- Formatting: CI-style check locally with `terraform fmt -check -recursive`.

## Commit & Pull Request Guidelines
- Commit style: Conventional Commits (e.g., `feat:`, `fix:`, `chore:`, `refactor:`, `wip:`) as used in history.
- PRs must include: purpose/changes summary, linked issues, relevant diffs, and `terraform plan` output for the target workspace.
- Safety: Call out any destructive changes (deletes/recreates), credential or network impacts.

## Security & Configuration Tips
- Secrets: Copy `.env.example` to `.env`; never commit secrets. `variables.tf` is ignored by Git—store sensitive values there.
- Backend: S3-compatible R2 backend from `terraform.tf`; ensure required env vars are set before `terraform init`.

## Perforce (p4d) Integration
- Variables: Configure via `p4d_config` object in `terraform/elysia.auto.tfvars` (Git-ignored).
  - `enabled` (bool): toggle deployment
  - `image` (string): container image for Helix Core server
  - `storage_size` (string): PVC request (e.g., `50Gi`)
  - `node_port` (number): NodePort to expose `1666/TCP` externally
- Cloud-init: When enabled, the eden control-plane seeds `/var/lib/rancher/k3s/server/manifests/p4d.yml`.
- No secrets in repo: do not commit credentials, license files, or bootstrap admin passwords. Use Kubernetes Secrets applied post‑provision or inject via a Git-ignored tfvars.
