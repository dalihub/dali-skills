---
name: dali-skill-creator
description: Use this skill when creating or modifying skill definitions in the dali-skills repository.
metadata:
  x-updated: "2026-09-04T01:04:38Z"
---

# DALi Skill Creator

## Repository Rules

- Develop and distribute each skill from the Git branch with the same name.
- The skill branch name, skill directory name, and `SKILL.md` `name` must match.
- The `main` branch is the repository entry point, skill index, and CODE-Skills Hub aggregation branch.
- Mirror every available skill directory onto `main` so repository scanners can discover all `SKILL.md` files from the default branch.
- Keep each mirrored skill directory on `main` identical to the corresponding skill branch.
- Do not split skills by coding agent type such as Codex or Claude.
- A skill branch root must contain only one skill directory named after the skill, plus repository metadata such as `.git`.
- Remove root-level files inherited from `main`, such as `README.md`, from skill branches.

## SKILL.md Rules

- Include `name`, `description`, and `metadata.x-updated` in frontmatter.
- Use UTC ISO-8601 format for `metadata.x-updated`.
- Update `metadata.x-updated` whenever the skill content changes.
- Keep `description` trigger-focused and compact.
- Keep the body compact; move large conditional details into `references/`.
- Do not add auxiliary files such as `README.md`, install guides, changelogs, or quick references unless explicitly requested.

## main Aggregation and README Index

- Copy the complete skill directory from its namesake branch to `main` after every skill change.
- Update `README.md` on `main` after adding or renaming a skill.
- Add app-facing skills to `App Developer Skills`.
- Add DALi framework, repository, tooling, or documentation skills to `DALi Developer Skills`.
- Use only `Skill` and `Description` columns.

## Default Workflow

1. Start from a clean `dali-skills/main`.
2. Create or switch to the skill branch named exactly like the skill.
3. Add or update `<skill-name>/SKILL.md`.
4. Set or refresh `metadata.x-updated` with the current UTC timestamp.
5. Validate and commit the skill branch.
6. Switch back to `main` and mirror the complete skill directory from the skill branch.
7. Update the README skill index when needed, validate all mirrored skills, and commit `main` separately.
