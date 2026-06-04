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

# Seed Mansur Jr's bootstrap files into the workspace.
# The workspace lives on /tmp and resets every boot, so copy them fresh each start.
workspace_dir="${OPENCLAW_WORKSPACE_DIR:-/home/node/.openclaw/workspace}"
echo "[entrypoint] seeding workspace at $workspace_dir"
mkdir -p "$workspace_dir"
cp /app/workspace/*.md "$workspace_dir/"
echo "[entrypoint] seeded workspace:"
ls -1 "$workspace_dir"

exec "$@"