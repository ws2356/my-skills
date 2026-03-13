#!/usr/bin/env bash
set -euo pipefail

agent_type=
while [ "$#" -gt 0 ]; do
  case "$1" in
    --agent|-a)
      agent_type="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

if [[ -z "$agent_type" ]]; then
  agent_type="opencode claude gemini"
fi

IFS_="$IFS"
IFS=', ' read -ra agent_types <<< "$agent_type"
IFS="$IFS_"

echo "Installing skills for agent types: ${agent_types[*]}"

this_file="$0"
if [[ "$this_file" != /* ]]; then
  this_file="$(pwd)/$this_file"
fi
this_dir="$(dirname "$this_file")"

for agent in "${agent_types[@]}"; do
    TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/.${agent}/skills"
    mkdir -p "$TARGET_DIR"

    for skill in "$this_dir/.opencode/skills"/*; do
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
done
