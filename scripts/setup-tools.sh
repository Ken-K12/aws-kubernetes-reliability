#!/usr/bin/env bash

set -euo pipefail

echo "==> Installing base packages..."

sudo apt-get update
sudo apt-get install -y \
  curl \
  unzip \
  gnupg \
  software-properties-common \
  jq

# Terraform
if ! command -v terraform >/dev/null 2>&1; then
  echo "==> Installing Terraform..."

  curl -fsSL https://apt.releases.hashicorp.com/gpg \
    | sudo gpg --dearmor \
      -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

  echo \
    "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com \
$(lsb_release -cs) main" \
    | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null

  sudo apt-get update
  sudo apt-get install -y terraform
else
  echo "==> Terraform already installed."
fi

# AWS CLI
if ! command -v aws >/dev/null 2>&1; then
  echo "==> Installing AWS CLI..."

  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
    -o "/tmp/awscliv2.zip"

  unzip -q /tmp/awscliv2.zip -d /tmp

  sudo /tmp/aws/install

  rm -rf /tmp/aws /tmp/awscliv2.zip
else
  echo "==> AWS CLI already installed."
fi

echo "==> Checking installed tools..."

terraform version
aws --version
kubectl version --client
jq --version

echo "==> Setup complete."