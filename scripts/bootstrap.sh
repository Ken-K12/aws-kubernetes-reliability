#!/usr/bin/env bash

set -euo pipefail

directories=(
  ".github"
  "terraform"
  "k8s"
  "scripts"
  "skills/kubernetes-review"
)

files=(
  "README.md"
  ".github/copilot-instructions.md"

  "terraform/versions.tf"
  "terraform/providers.tf"
  "terraform/variables.tf"
  "terraform/network.tf"
  "terraform/eks.tf"
  "terraform/outputs.tf"
  "terraform/terraform.tfvars.example"

  "k8s/deployment.yaml"
  "k8s/service.yaml"
  "k8s/hpa.yaml"

  "skills/kubernetes-review/SKILL.md"
)

for dir in "${directories[@]}"; do
  mkdir -p "${dir}"
done

for file in "${files[@]}"; do
  touch "${file}"
done

echo "Repository structure initialized."