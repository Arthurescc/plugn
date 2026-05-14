#!/usr/bin/env bash
set -euo pipefail

scripts=(aws-template-dev-docker.sh aws-template-docker.sh)

for script in "${scripts[@]}"; do
  bash -n "$script"

  grep -q 'set -euo pipefail' "$script"
  grep -q 'openssh-client git' "$script"
  grep -q 'eval "$(ssh-agent -s)"' "$script"
  grep -q 'sudo chown -R ubuntu:ubuntu /home/ubuntu/plugn' "$script"
  grep -q 'sudo mkdir -p /var/www' "$script"
  grep -q 'mkdir -p ~/.ssh' "$script"
  grep -q 'GITHUB_DEPLOY_KEY' "$script"
  grep -Fq "printf '%s\n' \"\$GITHUB_DEPLOY_KEY\" > ~/.ssh/github" "$script"
  grep -q 'ssh-keygen -y -f ~/.ssh/github > ~/.ssh/github.pub' "$script"
  grep -q 'git remote set-url origin git@github.com:plugnio/plugn.git' "$script"

  if grep -q 'openssh-clients' "$script"; then
    echo "$script uses the non-Ubuntu openssh-clients package name" >&2
    exit 1
  fi

  if grep -q 'github private key\|github public key' "$script"; then
    echo "$script must not write literal placeholder GitHub keys" >&2
    exit 1
  fi

  if grep -q 'git remote add git@github.com:plugnio/plugn.git' "$script"; then
    echo "$script uses invalid git remote add syntax" >&2
    exit 1
  fi
done

echo "PASS AWS bootstrap scripts use injected deploy keys and valid Ubuntu/git setup"
