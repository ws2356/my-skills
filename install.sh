#!/usr/bin/env bash
set -euo pipefail

agent_type=
is_global=false
while [ "$#" -gt 0 ]; do
  case "$1" in
    --agent|-a)
      agent_type="$2"
      shift 2
      ;;
    --global|-g)
      is_global=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

project_root=
if ! $is_global; then
  project_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
fi
if -z "$project_root" && ! $is_global; then
  echo "Error: Not inside a git repository. Use --global to install globally."
  exit 1
fi

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
    if $is_global; then
        echo "Installing $agent skills globally"
        TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/.${agent}/skills"
    else
        echo "Installing $agent skills for project at $project_root"
        TARGET_DIR="$project_root/.${agent}/skills"
    fi

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
