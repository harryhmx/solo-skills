# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a centralized collection of Agent Skills - reusable, self-contained modules designed for AI-assisted development workflows. Skills are developed for personal projects but maintained separately for reusability.

**Key principle**: Agent Skills are developed once and reused across projects. The actual project code lives in separate repositories, with symlinked skills when needed.

---

## Repository Structure

```
.
├── .claude/
│   └── skills/                    # All Agent Skills
│       ├── astro-project-init/    # Astro project scaffolding
│       ├── content-layout-expert/ # DOCX/PDF to Markdown conversion
│       ├── image-stitch/          # Image stitching/compositing
│       ├── md-to-pdf/             # Markdown to PDF with Chinese font support
│       └── tailwind-layout-system/# Complete layouts for Astro projects
├── .internal/
│   ├── docs/                      # Skill development documentation
│   └── demo/                      # Testing/demo files
└── README.md                      # Skills overview and quick reference
```

---

## Skill Structure (Standard Template)

Each skill follows this structure:

```
<skill-name>/
├── SKILL.md          # REQUIRED: YAML front matter + documentation
├── scripts/          # Executable scripts (bash, python, etc.)
│   └── <script>.sh/py
└── references/       # Supporting documentation and guides
    └── *.md
```

**SKILL.md front matter format:**
```yaml
---
name: skill-name
description: "Brief description with use cases"
author: AuthorName
version: "1.0.0"
---
```

---

## Current Skills Overview

| Skill | Language | Purpose | Key Dependencies |
|-------|----------|---------|------------------|
| `astro-project-init` | Bash | Initialize Astro projects with Tailwind CSS | Node.js, npm |
| `content-layout-expert` | Python | Convert DOCX/PDF to Markdown with image/table extraction | python-docx, pypdf, mammoth |
| `image-stitch` | Python | Stitch multiple images into one composite | Pillow (PIL) |
| `md-to-pdf` | Python | Convert Markdown to PDF with Chinese fonts | weasyprint, markdown |
| `tailwind-layout-system` | Bash | Add complete layouts to existing Astro projects | Requires astro-project-init output |

---

## Skill Dependencies

### Bash Skills (astro-project-init, tailwind-layout-system)
- Must be executable: `chmod +x scripts/*.sh`
- Use `set -e` for error handling
- Color output functions: `print_header()`, `print_step()`, `print_success()`

### Python Skills (content-layout-expert, image-stitch, md-to-pdf)
- Use virtual environment: `source ~/venv/hepmad/bin/activate`
- Dependencies listed in `references/requirements.txt`
- Shebang: `#!/usr/bin/env python3`

---

## Skill Usage Patterns

### Direct Execution
```bash
# Bash skills
bash ~/projects/huang/.claude/skills/<skill>/scripts/<script>.sh [args]

# Python skills (activate venv first)
source ~/venv/hepmad/bin/activate
python ~/projects/huang/.claude/skills/<skill>/scripts/<script>.py [args]
```

### Via AI Assistant
Describe the task naturally:
- *"Initialize a new Astro project"*
- *"Convert this DOCX to Markdown and extract images"*
- *"Convert this Markdown file to PDF"*
- *"Stitch these images together vertically"*

### Symlinking Skills to Projects
For projects that need specific skills (e.g., an Astro project needs astro-project-init):
```bash
ln -s ~/projects/huang/.claude/skills/astro-project-init ~/projects/your-project/.claude/skills/astro-project-init
```

---

## Development Workflow

When creating or modifying skills:

1. **Skill Creation**: Document in `.internal/docs/create-*-skill.md`
2. **Skill Development**: Follow standard template structure
3. **Testing**: Use `.internal/demo/` for test files
4. **Documentation**: Update README.md Quick Reference table
5. **SKILL.md**: Maintain version number and description

---

## Code Conventions

- **All code comments**: English (not Chinese)
- **Skill names**: kebab-case (e.g., `astro-project-init`, `md-to-pdf`)
- **Bash scripts**: Use functions for modularity, colored output for UX
- **Python scripts**: Type hints where helpful, clear docstrings
- **File paths**: Always use absolute paths in scripts (not relative)

---

## Design Systems

### Late Night Flight Dark Theme
Used by astro-project-init and tailwind-layout-system:
- Backgrounds: `#0F1117` (primary), `#1A1D27` (secondary), `#2A2E3D` (tertiary)
- Text: `#E8E6E1` (primary), `#8B8FA8` (secondary), `#6B7280` (muted)
- Accents: `#C9A84C` (gold), `#5B8FD4` (blue)
- Typography: Playfair Display (headings), Inter (body)

---

## File Path References

**Absolute paths (use these in scripts):**
- Skills root: `~/projects/huang/.claude/skills/`
- Virtual environment: `~/venv/hepmad/` (or your preferred venv)

**Relative paths (use these in documentation):**
- From repo root: `.claude/skills/<skill>/SKILL.md`
