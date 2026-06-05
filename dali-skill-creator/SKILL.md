---
name: dali-skill-creator
description: Use this skill when creating or modifying skill definitions in the dali-skills repository.
x-updated: "2026-06-05T11:44:11Z"
---

# DALi Skill Creator

## Repository Rules

- One skill occupies one Git branch.
- The skill branch name, skill directory name, and `SKILL.md` `name` must match.
- The `main` branch is only the repository entry point and skill index.
- Do not put individual skill implementations on `main`.
- Do not split skills by coding agent type such as Codex or Claude.
- A skill branch root must contain only one skill directory named after the skill, plus repository metadata such as `.git`.
- Remove root-level files inherited from `main`, such as `README.md`, from skill branches.

## SKILL.md Rules

- Include `name`, `description`, and `x-updated` in frontmatter.
- Use UTC ISO-8601 format for `x-updated`.
- Update `x-updated` whenever the skill content changes.
- Keep `description` trigger-focused and compact.
- Keep the body compact; move large conditional details into `references/`.
- Do not add auxiliary files such as `README.md`, install guides, changelogs, or quick references unless explicitly requested.

## main README Index

- Update `README.md` on `main` after adding a new skill branch.
- Add app-facing skills to `App Developer Skills`.
- Add DALi framework, repository, tooling, or documentation skills to `DALi Developer Skills`.
- Use only `Skill` and `Description` columns.

## Default Workflow

1. Start from a clean `dali-skills/main`.
2. Create or switch to the skill branch named exactly like the skill.
3. Add or update `<skill-name>/SKILL.md`.
4. Set or refresh `x-updated` with the current UTC timestamp.
5. Commit the skill branch.
6. Switch back to `main`, update the README skill index when needed, and commit that separately.
