---
name: dali-ui-wiki-docs
description: Use this skill when creating, editing, translating, or reviewing DALi UI GitHub wiki documents, especially when maintaining English and Korean page pairs, language links, section spacing, Home links, and wiki footer navigation.
x-updated: "2026-06-05T10:40:51Z"
---

# DALi UI Wiki Docs

Use this skill when working on DALi UI wiki markdown pages under `dali-ui/wiki`.

## Core Rules

- Keep English pages and Korean `(kr)` pages paired.
- When changing meaningful content in one language, check whether the paired page needs the same structural or content update.
- Korean page names usually use the same base page name with `-(kr)` before `.md`, for example `State-Management.md` and `State-Management-(kr).md`.
- Preserve existing page-name casing. Some existing pages may use nonstandard casing such as `(Kr)`; follow the existing filename unless renaming is explicitly requested.
- Use absolute wiki links: `https://github.sec.samsung.net/NUI/dali-ui/wiki/...`.
- Keep section structure aligned across language pairs unless the user intentionally requests otherwise.

## Page Format

English pages must include a Korean document link above the first section title:

```markdown
[→ 한국어 문서](https://github.sec.samsung.net/NUI/dali-ui/wiki/Page-Name-(kr))

# Page Title
```

Korean pages normally start directly with the title.

- Put `<br/>` between major sections to create readable spacing in GitHub Wiki.
- Use the same spacing style in both English and Korean pages.
- Do not add `<br/>` inside code blocks, tables, or tight list structures.

## Footer Navigation

End wiki pages with a horizontal rule and a Back to list link:

```markdown
---

[← Back to list](https://github.sec.samsung.net/NUI/dali-ui/wiki#development-guides)
```

For Korean pages:

```markdown
---

[← Back to list](https://github.sec.samsung.net/NUI/dali-ui/wiki/Home-(kr)#development-guides)
```

- If the page is listed under `Development Guides`, link to `#development-guides`.
- If it is listed under another Home section, link to that section anchor.
- If it is not listed in Home, link to the language-specific Home root: English `.../wiki`, Korean `.../wiki/Home-(kr)`.

## Home Updates

When adding a wiki page that should appear in Home:

- Update both `Home.md` and `Home-(kr).md`.
- Put the English page link in `Home.md`.
- Put the Korean page link in `Home-(kr).md`.
- Keep the page position consistent between the English and Korean Home lists.
- If adding under `Development Guides`, make the page footer point to the `#development-guides` anchor in both languages.

## Default Workflow

1. Read the target page, its paired language page, and Home files when relevant.
2. Keep headings, examples, tables, spacing, language links, and footer navigation aligned.
3. Update both Home language versions when the page should be listed.
4. Report any missing paired page or Home-list ambiguity to the user.
