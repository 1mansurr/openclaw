#!/bin/sh
set -e

state_dir="${OPENCLAW_STATE_DIR:-/tmp/.openclaw}"
config_file="${state_dir}/openclaw.json"

mkdir -p "$state_dir"

if [ ! -f "$config_file" ]; then
  printf '{"agents":{"defaults":{"model":{"primary":"anthropic/claude-sonnet-4-6"}}}}\n' > "$config_file"
fi

exec "$@"
