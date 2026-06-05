# DALi Agent Skills

This repository provides coding agent skills for DALi development.

Each skill is managed as a separate Git branch. The branch name is the skill
name, and that branch contains the installable skill directory.

The `main` branch is only the entry point for this repository. It does not
contain the individual skill implementations.

## How Skills Are Distributed

- One skill is stored in one branch.
- The branch name matches the skill name.
- The branch contains a directory with the same name as the skill.
- Skills are not split by coding agent type such as Claude or Codex.
- Users install a skill by cloning the matching branch into a location that
  their coding agent can read.

For example, if a skill is named `dali-ui-view-inheritance`, it is provided by
the `dali-ui-view-inheritance` branch. That branch contains the
`dali-ui-view-inheritance` skill directory.

## Install A Skill

Choose the skill branch you want and clone only that branch into the directory
where your coding agent reads skills:

```bash
git clone -b <skill-name> --single-branch \
  https://github.com/dalihub/dali-skills.git \
  <agent-skills-dir>
```

Example:

```bash
git clone -b dali-ui-view-inheritance --single-branch \
  https://github.com/dalihub/dali-skills.git \
  ~/.codex/skills
```

After cloning, the skill directory is placed under the destination directory:

```text
<agent-skills-dir>/
  <skill-name>/
    SKILL.md
    ...
```

Use the destination directory expected by your coding agent. The destination
directory must not already exist unless it is empty. If your agent's skills
directory already exists and contains other skills, clone into a temporary
directory first and then copy or move the skill directory into the agent's
skills directory.

After installing or updating a skill, restart the coding agent if it does not
reload skills automatically.

## Update A Skill

Go to the cloned repository directory and pull the latest version of that
branch:

```bash
git -C <agent-skills-dir> pull
```

Example:

```bash
git -C ~/.codex/skills pull
```

## List Available Skills

Available skills are the remote branches in this repository:

```bash
git ls-remote --heads https://github.com/dalihub/dali-skills.git
```

Each branch name after `refs/heads/` is a skill name.
