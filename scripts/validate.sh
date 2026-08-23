#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="${ROOT}/skills"
ERRORS=0
COUNT=0

report_error() {
  echo "Error: $*" >&2
  ERRORS=$((ERRORS + 1))
}

[[ -d "${SKILLS_DIR}" ]] || { echo "Error: missing skills/ directory." >&2; exit 1; }

for directory in "${SKILLS_DIR}"/*; do
  [[ -d "${directory}" ]] || continue
  COUNT=$((COUNT + 1))
  name="$(basename "${directory}")"
  skill_file="${directory}/SKILL.md"

  [[ "${name}" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || report_error "invalid skill directory name: ${name}"
  if [[ ! -f "${skill_file}" ]]; then
    report_error "${name} is missing SKILL.md"
    continue
  fi

  first_line="$(sed -n '1p' "${skill_file}")"
  [[ "${first_line}" == "---" ]] || report_error "${name}/SKILL.md must start with YAML frontmatter"

  frontmatter="$(awk 'NR == 1 { next } /^---$/ { exit } { print }' "${skill_file}")"
  declared_name="$(printf '%s\n' "${frontmatter}" | sed -n 's/^name:[[:space:]]*//p' | head -n 1)"
  description="$(printf '%s\n' "${frontmatter}" | sed -n 's/^description:[[:space:]]*//p' | head -n 1)"
  keys="$(printf '%s\n' "${frontmatter}" | sed -n 's/^\([A-Za-z0-9_-]*\):.*/\1/p')"

  [[ "${declared_name}" == "${name}" ]] || report_error "${name}/SKILL.md name must equal directory name"
  [[ -n "${description}" ]] || report_error "${name}/SKILL.md needs a non-empty description"
  while IFS= read -r key; do
    [[ -z "${key}" || "${key}" == "name" || "${key}" == "description" ]] || report_error "${name}/SKILL.md has unsupported frontmatter key: ${key}"
  done <<< "${keys}"
done

if ((COUNT == 0)); then
  echo "No skills found; repository structure is valid."
elif ((ERRORS > 0)); then
  echo "Validation failed with ${ERRORS} error(s)." >&2
  exit 1
else
  echo "Validated ${COUNT} skill(s)."
fi
