---
name: astro-project-init
description: "Initialize a Hepmad Astro project with Tailwind CSS and basic page scaffolding"
author: Harry
version: "1.1.0"
---

# Astro Project Init Skill

A skill for creating a standardized Hepmad Astro project with Tailwind CSS integration and basic page structure.

## Use Cases

- Create a new Hepmad Astro project from scratch
- Set up Tailwind CSS integration with "Late Night Flight" dark theme
- Generate base project structure with minimal Home page
- Create BaseLayout with Navbar and Footer components

## Input

| Parameter | Description | Default | Required |
|-----------|-------------|---------|----------|
| `project_name` | Name of the Astro project | `hepmad` | No |
| `target_dir` | Target directory for the project | Current directory | No |

## Output

- Complete Astro project structure with:
  - `src/components/` - Reusable Astro components (Navbar, Footer)
  - `src/layouts/` - Layout components (BaseLayout)
  - `src/pages/` - Page components (index.astro - minimal Hero only)
  - `src/styles/` - Global styles

- Configuration files:
  - `astro.config.mjs` - Astro configuration
  - `tailwind.config.mjs` - Tailwind CSS configuration with "Late Night Flight" dark theme
  - `package.json` - Dependencies and scripts
  - `.gitignore` - Git ignore rules

## How to Use

### Option 1: Using the Bash Script

```bash
# Run the skill script directly
bash ~/projects/hepmad/.claude/skills/astro-project-init/scripts/init.sh [project_name] [target_dir]

# Example: Create in current directory
bash ~/projects/hepmad/.claude/skills/astro-project-init/scripts/init.sh hepmad .
```

### Option 2: Interactive with Claude Code

```
"Use the astro-project-init skill to create a new Hepmad Astro project named 'hepmad' in the current directory."
```

## Scripts

### `init.sh`

Main script that initializes the Astro project with all necessary files and configurations.

**Features:**
- Creates Astro project structure from scratch
- Generates and configures all necessary files
- Creates BaseLayout with Navbar and Footer
- Creates minimal Home page (Hero only) for project verification
- Sets up Tailwind CSS with "Late Night Flight" dark theme

**Usage:**
```bash
bash scripts/init.sh [project_name] [target_dir]
```

**Example:**
```bash
# Create project in current directory
bash scripts/init.sh hepmad .

# Create project in specific directory
bash scripts/init.sh hepmad ~/projects
```

## Project Structure

```
src/
├── components/
│   ├── Navbar.astro       # Navigation bar component
│   └── Footer.astro       # Footer component
├── layouts/
│   └── BaseLayout.astro   # Main layout wrapper
├── pages/
│   └── index.astro        # Home page (minimal Hero)
└── styles/
    └── global.css         # Global styles
```

## Dependencies

**Node.js packages:**
- `astro` - Astro framework
- `@astrojs/tailwind` - Tailwind CSS integration for Astro
- `tailwindcss` - Utility-first CSS framework

**System requirements:**
- Bash shell (Linux/macOS/WSL)
- Node.js 18+ and npm

## Page Details

### Home Page (`index.astro`)

Minimal page with Hero section only. Serves as project verification and starting point for further development.

**Content:**
- **Hero**: Welcome message with instructions to run `npm run dev`
- Prompt to use `tailwind-layout-system` skill for full page layouts

## Design System

### Late Night Flight Dark Theme

The skill creates a professional dark-themed website with the "Late Night Flight" (深夜航班) color palette:

**Colors:**
- Background: `#0F1117` (primary), `#1A1D27` (secondary), `#2A2E3D` (tertiary)
- Text: `#E8E6E1` (primary), `#8B8FA8` (secondary), `#6B7280` (muted)
- Accents: `#C9A84C` (gold), `#5B8FD4` (blue)

**Typography:**
- Headings: Playfair Display (serif) - elegant, editorial feel
- Body: Inter (sans-serif) - clean, highly readable

**Design Principles:**
- High contrast for readability
- Warm gold accents for keywords and highlights
- Soft blue for links and CTAs
- Generous whitespace for visual breathing room
- Mobile-first responsive design

## Notes

**Skill Focus:**
- This skill provides the **foundation** only - a runnable Astro project with dark theme
- Full page layouts and blog system are handled by `tailwind-layout-system` skill
- Minimal content to verify project setup works correctly

**Design Principles:**
- Static-first approach
- Zero JavaScript by default
- Minimal dependencies
- Clean, readable code structure

**Post-Installation:**
1. Run `npm install` to install dependencies
2. Run `npm run dev` to start development server
3. Open `http://localhost:4321` to view the site
4. Use `tailwind-layout-system` skill to add full page layouts

**Next Steps:**
- Use the `tailwind-layout-system` skill to add:
  - Complete Home page (About, Blog preview, Contact sections)
  - Blog listing page with category filtering
  - Blog post detail pages
  - Content Collections configuration
  - Sample blog posts

**Future Enhancements:**
- Dark/light mode toggle (currently dark mode only)
- SEO optimization (meta tags, sitemap, robots.txt)
- Additional pages (About, Contact, Projects - added as needed)
- Analytics integration
