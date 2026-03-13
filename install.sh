#!/usr/bin/env bash
set -euo pipefail

this_file="$0"
if [[ "$this_file" != /* ]]; then
  this_file="$(pwd)/$this_file"
fi
this_dir="$(dirname "$this_file")"

TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/skills"
mkdir -p "$TARGET_DIR"

for skill in "$this_dir/skills"/*; do
    if [[ -d "$skill" ]]; then
        skill_name="$(basename "$skill")"
        target="$TARGET_DIR/$skill_name"
        if [[ -e "$target" ]]; then
            echo "Warning: $target already exists, skipping $skill_name"
        else
            ln -s "$skill" "$target"
            echo "Installed $skill_name to $target"
        fi
    fi
done