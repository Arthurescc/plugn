#!/usr/bin/env bash
set -euo pipefail

dockerfile="cron/Dockerfile"
compose_file="docker-compose-apache-prod.yml"

grep -q 'COPY cronlist /etc/cron.d/simple-cron' "$dockerfile"
grep -q 'apt-get install -y --no-install-recommends cron php-cli' "$dockerfile"
grep -q 'ln -s /usr/bin/php /usr/local/bin/php' "$dockerfile"
grep -q 'ln -s /app /root/www' "$dockerfile"
grep -q 'crontab /etc/cron.d/simple-cron' "$dockerfile"
grep -q 'CMD \["cron", "-f"\]' "$dockerfile"

if grep -q 'ADD crontab' "$dockerfile"; then
  echo "cron Dockerfile must not reference missing cron/crontab" >&2
  exit 1
fi

grep -A8 '^  cron-prod:' "$compose_file" | grep -q 'depends_on:'
grep -A8 '^  cron-prod:' "$compose_file" | grep -q 'init-environment-prod'

echo "PASS cron Dockerfile uses the tracked cronlist and runs cron in foreground"
