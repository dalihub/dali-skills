# DALi Agent Skills

This repository provides coding agent skills for DALi development.

Each skill is managed as a separate Git branch. The branch name is the skill
name, and that branch contains the installable skill directory.

<br/>

## Available Skills

### App Developer Skills

| Skill | Description |
|---|---|
| `dali-ui-view-inheritance` | Create a new DALi UI class derived from `Dali::Ui::View`. |

<br/>

### DALi Developer Skills

| Skill | Description |
|---|---|
| `dali-skill-creator` | Add, update, or organize skills in the `dali-skills` repository. |
| `dali-ui-wiki-docs` | Create, edit, translate, or review DALi UI GitHub wiki documents. |

To check every published skill branch:

```bash
git ls-remote --heads https://github.com/dalihub/dali-skills.git
```

<br/>

## Install A Skill

```bash
curl -fsSL https://raw.githubusercontent.com/dalihub/dali-skills/main/install.sh | bash -s -- <skill-name> <agent-skills-dir>
```

This command installs or updates the selected skill in the location where your
coding agent reads skills.

- **`<skill-name>`**: The skill to install. Choose one from
  [Available Skills](#available-skills).
- **`<agent-skills-dir>`**: The coding agent skills directory. See the table
  below.

#### Coding Agent Install Locations

| Agent | Scope | Agent skills directory |
|---|---|---|
| Codex | Project-local | `<project-root>/.agents/skills` |
| Codex | User-global | `~/.agents/skills` |
| Claude Code | Project-local | `<project-root>/.claude/skills` |
| Claude Code | User-global | `~/.claude/skills` |

Use project-local installation when the skill should apply only to one project.
Use user-global installation when the skill should be available everywhere.

After installing, the skill looks like this:

```text
<agent-skills-dir>/
  <skill-name>/
    SKILL.md
    ...
```

#### Example 1

Install `dali-ui-view-inheritance` for Codex in one project:

```bash
curl -fsSL https://raw.githubusercontent.com/dalihub/dali-skills/main/install.sh | bash -s -- dali-ui-view-inheritance <project-root>/.agents/skills
```

#### Example 2

Install `dali-ui-wiki-docs` globally for Claude Code:

```bash
curl -fsSL https://raw.githubusercontent.com/dalihub/dali-skills/main/install.sh | bash -s -- dali-ui-wiki-docs ~/.claude/skills
```

After installing or updating a skill, **restart the coding agent** if it does not
reload skills automatically.

## Update A Skill

Run the install command again with the same `<skill-name>` and
`<agent-skills-dir>`.
