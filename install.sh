#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/dalihub/dali-skills"

usage()
{
  echo "Usage: install.sh <skill-name> <agent-skills-dir>" >&2
}

if [ "$#" -ne 2 ]; then
  usage
  exit 1
fi

skill_name="$1"
agent_skills_dir="$2"

if [ -z "$skill_name" ]; then
  echo "Missing skill name" >&2
  usage
  exit 1
fi

if [ -z "$agent_skills_dir" ]; then
  echo "Missing agent skills directory" >&2
  usage
  exit 1
fi

if [ "$skill_name" = "{skill-name}" ]; then
  echo "Replace {skill-name} with a real skill name." >&2
  exit 1
fi

if [ "$agent_skills_dir" = "{agent-skills-dir}" ]; then
  echo "Replace {agent-skills-dir} with a real agent skills directory." >&2
  exit 1
fi

case "$skill_name" in
  ""|.*|*/*|*\\*)
    echo "Invalid skill name: $skill_name" >&2
    exit 1
    ;;
esac

if ! printf '%s' "$skill_name" | grep -Eq '^[A-Za-z0-9._-]+$'; then
  echo "Invalid skill name: $skill_name" >&2
  exit 1
fi

if [ -e "$agent_skills_dir" ] && [ ! -d "$agent_skills_dir" ]; then
  echo "Destination is not a directory: $agent_skills_dir" >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
target_tmp=""
cleanup()
{
  rm -rf "$tmp_dir"
  if [ -n "$target_tmp" ]; then
    rm -rf "$target_tmp"
  fi
}
trap cleanup EXIT

archive="$tmp_dir/skill.tar.gz"
extract_dir="$tmp_dir/extract"
mkdir -p "$extract_dir"

curl -fsSL "$REPO_URL/archive/refs/heads/$skill_name.tar.gz" -o "$archive"
tar -xzf "$archive" --strip-components=1 -C "$extract_dir"

source_dir="$extract_dir/$skill_name"
if [ ! -d "$source_dir" ]; then
  echo "Skill directory not found in branch: $skill_name" >&2
  exit 1
fi

mkdir -p "$agent_skills_dir"

target_dir="$agent_skills_dir/$skill_name"
target_tmp="$agent_skills_dir/.$skill_name.tmp.$$"

rm -rf "$target_tmp"
cp -R "$source_dir" "$target_tmp"
rm -rf "$target_dir"
mv "$target_tmp" "$target_dir"
target_tmp=""

echo "Installed $skill_name to $target_dir"
