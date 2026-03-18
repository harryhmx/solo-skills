---
name: tailwind-layout-system
description: "Add complete page layouts (Hero, About, Blog, Contact) and blog system to an existing Astro project. Use when enhancing an Astro project created by astro-project-init with: full Home page, blog listing with category filtering, blog post detail pages, Content Collections configuration, and sample blog content."
---

# Tailwind Layout System Skill

A skill for adding complete page layouts and blog functionality to an existing Astro project created by `astro-project-init`.

## Use Cases

- Add complete Home page with multiple sections (About, Blog preview, Contact)
- Add Blog listing page with category filtering
- Add Blog post detail pages
- Set up Content Collections for blog posts
- Add sample blog content

## Input

| Parameter | Description | Default | Required |
|-----------|-------------|---------|----------|
| `project_dir` | Path to existing Astro project | Current directory | No |

## Output

- Enhanced project structure with:
  - `src/pages/index.astro` - Complete Home page (overwrites minimal version)
  - `src/pages/blog.astro` - Blog listing page with category filtering
  - `src/pages/blog/[...slug].astro` - Blog post detail page
  - `src/content/config.ts` - Content Collections configuration
  - `src/content/blog/` - Sample blog posts (3 posts)

## How to Use

### Option 1: Using the Bash Script

```bash
# Run from your Astro project directory
bash ~/projects/huang/.claude/skills/tailwind-layout-system/scripts/setup.sh [project_dir]

# Example: Run from current directory
bash ~/projects/huang/.claude/skills/tailwind-layout-system/scripts/setup.sh .
```

### Option 2: Interactive with Claude Code

```
"Use the tailwind-layout-system skill to add complete page layouts to my Astro project."
```

## Scripts

### `setup.sh`

Main script that adds complete page layouts and blog system to an existing Astro project.

**Prerequisites:**
- Must run on a project created by `astro-project-init` skill
- The project should have `astro-project-init`'s base structure and Tailwind config

**Features:**
- Overwrites minimal `index.astro` with complete Home page
- Creates `blog.astro` listing page with category filtering
- Creates `[...slug].astro` blog post detail page
- Sets up Content Collections configuration
- Adds 3 sample blog posts (one per category)

**Usage:**
```bash
bash scripts/setup.sh [project_dir]
```

## Page Details

### Home Page (`index.astro`)

Complete Home page with the following sections:

**Hero Section:**
- Large heading with serif font
- Subtitle describing the site's purpose
- CTA button linking to Blog

**About Section:**
- Introduction text
- Core values/points with gold-accented keywords
- Timeline with gold-highlighted years

**Blog Section:**
- Three category cards
- Hover effects with gold border
- Descriptions for each category

**Contact Section:**
- Email link
- GitHub link
- Simple, centered layout

### Blog Listing Page (`blog.astro`)

- Category filter buttons (All, Life Story, Travel, Solo Dev)
- Active state with blue background
- Blog post cards with:
  - Title (serif font, hover blue)
  - Date and category
  - Description
  - "Read more" link

### Blog Detail Page (`[...slug].astro`)

- Full blog post rendering from Markdown
- Back to Blog link
- Post metadata (date, category)
- Clean, readable typography

## Content Collections

### Configuration (`src/content/config.ts`)

```ts
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.coerce.date(),
    lang: z.enum(['en', 'zh']).default('en'),
    category: z.enum(['life-story', 'travel', 'solo-dev']),
  }),
});

export const collections = { blog };
```

### Sample Posts

1. **Category 1**: "Sample Post Title 1"
2. **Category 2**: "Sample Post Title 2"
3. **Category 3**: "Sample Post Title 3"

**Note:** The sample posts use generic category names (life-story, travel, solo-dev). You should customize these categories to match your content needs by editing the Content Collections schema and updating the blog pages accordingly.

## Design System

Uses the same "Late Night Flight" dark theme established by `astro-project-init`:

- Semantic color classes (`bg-bg-primary`, `text-text-primary`, `text-accent-gold`, etc.)
- Playfair Display for headings, Inter for body text
- Consistent spacing and container widths
- Mobile-first responsive design

## Dependencies

**Requires:**
- Existing Astro project with `astro-project-init` base setup
- Tailwind CSS configured with "Late Night Flight" theme

**No additional packages needed** - uses existing dependencies from `astro-project-init`

## Project Structure After Setup

```
src/
├── components/
│   ├── Navbar.astro
│   └── Footer.astro
├── layouts/
│   └── BaseLayout.astro
├── pages/
│   ├── index.astro        # Complete Home page (overwritten)
│   ├── blog.astro         # Blog listing (new)
│   └── blog/
│       └── [...slug].astro # Blog detail (new)
├── content/
│   ├── config.ts          # Content Collections config (new)
│   └── blog/              # Sample blog posts (new)
│       ├── life-story/
│       ├── travel/
│       └── solo-dev/
└── styles/
    └── global.css
```

## Notes

**Skill Focus:**
- This skill adds **content and layouts** to an existing project
- Does NOT modify Tailwind config or base layout
- Assumes `astro-project-init` has already been run

**Design Principles:**
- Reuses existing color system and typography
- Maintains consistency with base design
- Clean component structure for easy customization

**Post-Installation:**
1. Add your own blog posts in `src/content/blog/`
2. Customize page content as needed
3. Run `npm run dev` to see changes
