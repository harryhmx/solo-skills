# Collection of Customized Agent Skills

A curated collection of specialized Agent Skills designed for AI-assisted development workflows and productivity enhancement.

## Overview

This directory contains custom Agent Skills developed to streamline repetitive tasks and enable consistent project scaffolding. Each skill is a self-contained module with its own documentation, scripts, and dependencies, ready to be invoked by AI assistants or executed directly.

---

## Available Skills

### 1. astro-project-init

Initialize a Hepmad Astro project with Tailwind CSS and basic page scaffolding.

**Description:** Creates a standardized Astro project from scratch with the "Late Night Flight" dark theme, base components (Navbar, Footer, BaseLayout), and a minimal Home page for verification.

**Use Cases:**
- Create new Hepmad Astro projects
- Set up Tailwind CSS with custom dark theme
- Generate base project structure

**Version:** 1.1.0

---

### 2. content-layout-expert

Convert article drafts between formats with image/table extraction.

**Description:** Converts DOCX/PDF to Markdown with automatic image and table extraction, handles corrupted files via mammoth fallback, and converts Markdown to HTML for WeChat/Xiumi.

**Use Cases:**
- Convert article drafts (DOCX/PDF) to Markdown
- Extract images to `images/` directory
- Extract tables to `tables/` directory (XLSX with styling)
- Convert Markdown to HTML for WeChat Official Account
- Handle corrupted DOCX files

**Features:**
- Auto-heading conversion (first line to `#`)
- Position markers: `(image-N)`, `(table-N)`
- Styled XLSX table export
- Preserves text formatting (bold, italic)

**Version:** 1.0.0

---

### 3. md-to-pdf

Convert Markdown files to PDF with Chinese font support using WeasyPrint.

**Description:** Converts Markdown documents to professionally formatted PDFs with full Chinese character support, syntax highlighting, and clean styling.

**Use Cases:**
- Convert meeting notes to PDF
- Generate documentation PDFs
- Create reports with Chinese text

**Features:**
- Automatic Chinese font detection (Linux/macOS/Windows)
- Syntax highlighting for code blocks (GitHub Dark theme)
- Table of contents support
- Styled tables, headers, lists
- Page numbers

**Version:** 1.0.0

---

### 4. tailwind-layout-system

Add complete page layouts and blog system to an existing Hepmad Astro project.

**Description:** Enhances an Astro project created by `astro-project-init` with full page layouts, blog listing with category filtering, and Content Collections configuration.

**Use Cases:**
- Add complete Home page (Hero, About, Blog, Contact sections)
- Create blog listing page with category filtering
- Add blog post detail pages
- Set up Content Collections

**Features:**
- Overwrites minimal Home page with complete version
- Blog listing with category filters
- Three sample blog posts (Life Story, Travel, Solo Dev)
- Uses "Late Night Flight" dark theme

**Version:** 1.0.0

---

## Quick Reference

| Skill | Primary Function | Input | Output | Documentation |
|-------|------------------|-------|--------|---------------|
| `astro-project-init` | Initialize Astro project | project_name, target_dir | Complete Astro project structure | [SKILL.md](.claude/skills/astro-project-init/SKILL.md) |
| `content-layout-expert` | Convert document formats | .docx/.pdf/.md file | .md/.html + images/ + tables/ | [SKILL.md](.claude/skills/content-layout-expert/SKILL.md) |
| `md-to-pdf` | Markdown to PDF | .md file | .pdf file | [SKILL.md](.claude/skills/md-to-pdf/SKILL.md) |
| `tailwind-layout-system` | Add layouts to Astro project | project_dir | Enhanced pages + blog system | [SKILL.md](.claude/skills/tailwind-layout-system/SKILL.md) |

---

## Skill Relationships

Some skills work together in a workflow:

```
astro-project-init (foundation)
         ↓
tailwind-layout-system (enhance with layouts)
```

---

## Usage Patterns

### Direct Script Execution

```bash
# Astro project initialization
bash ~/projects/huang/.claude/skills/astro-project-init/scripts/init.sh hepmad .

# Content conversion
source ~/venv/hepmad/bin/activate && python ~/projects/huang/.claude/skills/content-layout-expert/scripts/convert_to_markdown.py input.docx

# Markdown to PDF
source ~/venv/hepmad/bin/activate && python ~/projects/huang/.claude/skills/md-to-pdf/scripts/convert.py input.md

# Add layouts to existing project
bash ~/projects/huang/.claude/skills/tailwind-layout-system/scripts/setup.sh .
```

### Via AI Assistant

Simply describe the task:

- *"Initialize a new Hepmad Astro project"*
- *"Convert this DOCX to Markdown and extract images"*
- *"Convert this Markdown file to PDF"*
- *"Add complete page layouts to my Astro project"*

---

## Directory Structure

```
.claude/skills/
├── README.md
├── astro-project-init/
│   ├── SKILL.md
│   ├── scripts/
│   │   └── init.sh
│   └── references/
│       └── tailwind-quick-ref.md
├── content-layout-expert/
│   ├── SKILL.md
│   ├── scripts/
│   │   ├── convert_to_markdown.py
│   │   └── convert_to_html.py
│   └── references/
│       └── requirements.txt
├── md-to-pdf/
│   ├── SKILL.md
│   ├── scripts/
│   │   └── convert.py
│   └── references/
│       ├── weasyprint-guide.md
│       ├── markdown-extensions.md
│       └── pygments-guide.md
└── tailwind-layout-system/
    ├── SKILL.md
    ├── scripts/
    │   └── setup.sh
    └── references/
        └── astro-content-collections.md
```

---

## Contributing

When adding new skills to this directory:

1. Create a new directory following kebab-case naming
2. Include a `SKILL.md` file with YAML front matter
3. Add executable scripts in a `scripts/` subdirectory
4. Include reference documentation in a `references/` subdirectory
5. Update this README with the new skill information

---

## License

These skills are part of the Huang project and are intended for personal and educational use.
