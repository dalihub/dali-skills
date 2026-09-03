# DALi Agent Skills

This repository provides coding agent skills for developing with DALi.

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
| `dali-dev-assist` | Provide evidence-grounded help for DALi code, API usage, samples, debugging, and documentation. |
| `dali-skill-creator` | Add, update, or organize skills in the `dali-skills` repository. |
| `dali-ui-wiki-docs` | Create, edit, translate, or review DALi UI GitHub wiki documents. |

<br/>

## Install A Skill

### Ubuntu / macOS

```bash
curl -fsSL https://raw.githubusercontent.com/dalihub/dali-skills/main/install.sh \
  | bash -s -- "{skill-name}" "{agent-skills-dir}"
```

- **`{skill-name}`**: The skill to install. Choose one from
  [Available Skills](#available-skills).
- **`{agent-skills-dir}`**: The coding agent skills directory. See [here](#coding-agent-install-locations).

<br/>

This command installs the selected skill in the location where your
coding agent reads skills. After installing or updating a skill, **restart the coding agent**.

For example,

```bash
curl -fsSL https://raw.githubusercontent.com/dalihub/dali-skills/main/install.sh \
  | bash -s -- "dali-ui-view-inheritance" "myapp/.agents/skills"
```
This command installs `dali-ui-view-inheritance` skill in the `myapp` project directory for Codex.

</br>

#### Coding Agent Install Locations

| Agent | Scope | Agent skills directory |
|---|---|---|
| Codex | Project-local | `<project-root>/.agents/skills` |
| Codex | User-global | `~/.agents/skills` |
| Claude Code | Project-local | `<project-root>/.claude/skills` |
| Claude Code | User-global | `~/.claude/skills` |

Use project-local installation when the skill should apply only to one project.
Use user-global installation when the skill should be available everywhere.

<br/>

### Windows

1. Open `https://github.com/dalihub/dali-skills`.
2. Select the branch named after the skill.
3. Download the branch as a ZIP file.
4. Extract it.
5. Copy the `<skill-name>` folder into your coding agent skills directory.

After installing or updating a skill, **restart the coding agent**.

<br/>

## Update A Skill

Run the install command again with the same `{skill-name}` and
`{agent-skills-dir}`.
