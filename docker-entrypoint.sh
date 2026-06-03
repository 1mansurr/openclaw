#!/bin/sh
set -e
echo "[entrypoint] starting docker-entrypoint.sh"
state_dir="${OPENCLAW_STATE_DIR:-/tmp/.openclaw}"
config_file="${state_dir}/openclaw.json"
echo "[entrypoint] state_dir=$state_dir config_file=$config_file"
mkdir -p "$state_dir"
if [ ! -f "$config_file" ]; then
  printf '{"agents":{"defaults":{"model":{"primary":"anthropic/claude-sonnet-4-6"}}}}\n' > "$config_file"
  echo "[entrypoint] wrote config to $config_file"
else
  echo "[entrypoint] config already exists at $config_file"
  cat "$config_file"
fi
exec "$@"
