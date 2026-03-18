#!/bin/bash

################################################################################
# Tailwind Layout System Setup Script
#
# Adds complete page layouts and blog system to an existing Astro project.
# Assumes the project was created with astro-project-init skill.
#
# Usage:
#   ./setup.sh [project_dir]
#
# Example:
#   ./setup.sh .
################################################################################

set -e  # Exit on error

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
PROJECT_DIR=${1:-.}

# Get absolute path
PROJECT_DIR_ABS=$(cd "$PROJECT_DIR" && pwd)

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo ""
    echo "=============================================================="
    echo "  $1"
    echo "=============================================================="
    echo ""
}

print_step() {
    echo -e "${BLUE}▶ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

################################################################################
# Validation Functions
################################################################################

validate_project() {
    print_step "Validating Astro project..."

    # Check if package.json exists
    if [ ! -f "$PROJECT_DIR_ABS/package.json" ]; then
        print_error "package.json not found. Is this an Astro project?"
        exit 1
    fi

    # Check if it's an Astro project
    if ! grep -q '"astro"' "$PROJECT_DIR_ABS/package.json"; then
        print_error "Astro dependency not found in package.json"
        exit 1
    fi

    # Check if src directory exists
    if [ ! -d "$PROJECT_DIR_ABS/src" ]; then
        print_error "src/ directory not found"
        exit 1
    fi

    print_success "Project validation passed"
}

################################################################################
# Main Functions
################################################################################

create_content_config() {
    cat > "$PROJECT_DIR_ABS/src/content/config.ts" << 'EOF'
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
EOF
    print_success "Created content/config.ts"
}

create_blog_directories() {
    mkdir -p "$PROJECT_DIR_ABS/src/content/blog/life-story"
    mkdir -p "$PROJECT_DIR_ABS/src/content/blog/travel"
    mkdir -p "$PROJECT_DIR_ABS/src/content/blog/solo-dev"
    mkdir -p "$PROJECT_DIR_ABS/src/pages/blog"
    print_success "Created blog directory structure"
}

create_home_page() {
    cat > "$PROJECT_DIR_ABS/src/pages/index.astro" << 'EOF'
---
import BaseLayout from '../layouts/BaseLayout.astro';
---

<BaseLayout title="MySite - Home">
  <!-- Hero Section -->
  <section class="border-b border-bg-tertiary px-4 py-24 sm:py-32 sm:px-6 lg:px-8">
    <div class="mx-auto max-w-5xl text-center">
      <h1 class="text-5xl font-bold font-serif tracking-tight text-text-primary sm:text-7xl">
        Welcome to MySite
      </h1>
      <p class="mt-8 text-xl leading-relaxed text-text-secondary sm:text-2xl">
        A modern website template with a beautiful dark theme and blog functionality.
        Customize this content to match your brand and message.
      </p>
      <div class="mt-12 flex items-center justify-center gap-x-6">
        <a href="/blog" class="rounded-md bg-accent-blue px-8 py-3 text-base font-semibold text-bg-primary shadow-sm hover:bg-accent-blue/90 transition-colors">
          Read the Blog
        </a>
      </div>
    </div>
  </section>

  <!-- About Section -->
  <section class="px-4 py-20 sm:px-6 lg:px-8" id="about">
    <div class="mx-auto max-w-4xl">
      <h2 class="text-3xl font-bold font-serif tracking-tight text-text-primary">About</h2>
      <p class="mt-6 text-lg leading-relaxed text-text-secondary">
        This is a template section where you can introduce yourself or your project.
        Replace this content with your own story, mission, or value proposition.
      </p>

      <h3 class="mt-12 text-2xl font-semibold text-text-primary">Core Values</h3>
      <ul class="mt-6 space-y-3 text-text-secondary">
        <li>• <span class="text-accent-gold">Value One</span> — Description of your first value</li>
        <li>• <span class="text-accent-gold">Value Two</span> — Description of your second value</li>
        <li>• <span class="text-accent-gold">Value Three</span> — Description of your third value</li>
        <li>• <span class="text-accent-gold">Value Four</span> — Description of your fourth value</li>
        <li>• <span class="text-accent-gold">Value Five</span> — Description of your fifth value</li>
      </ul>

      <h3 class="mt-12 text-2xl font-semibold text-text-primary">Timeline</h3>
      <div class="mt-6 space-y-3 text-text-secondary">
        <p><span class="text-accent-gold font-semibold">Year One</span> — First milestone or achievement</p>
        <p><span class="text-accent-gold font-semibold">Year Two</span> — Second milestone or achievement</p>
        <p><span class="text-accent-gold font-semibold">Year Three</span> — Third milestone or achievement</p>
        <p><span class="text-accent-gold font-semibold">Year Four</span> — Fourth milestone or achievement</p>
        <p><span class="text-accent-gold font-semibold">Year Five</span> — Fifth milestone or achievement</p>
        <p><span class="text-accent-gold font-semibold">Year Six</span> — Sixth milestone or achievement</p>
      </div>
    </div>
  </section>

  <!-- Blog Section -->
  <section class="border-t border-bg-tertiary bg-bg-secondary px-4 py-20 sm:px-6 lg:px-8">
    <div class="mx-auto max-w-5xl">
      <h2 class="text-3xl font-bold font-serif tracking-tight text-text-primary">Latest from the Blog</h2>
      <p class="mt-4 text-lg text-text-secondary">
        Explore articles organized by category.
      </p>

      <div class="mt-10 grid gap-6 sm:grid-cols-3">
        <a href="/blog?category=life-story" class="group rounded-lg border border-bg-tertiary bg-bg-primary p-8 shadow-sm hover:border-accent-gold/50 transition-all hover:shadow-md">
          <h3 class="text-2xl font-serif font-semibold text-text-primary group-hover:text-accent-gold transition-colors">
            Life Story
          </h3>
          <p class="mt-3 text-sm text-text-secondary">
            Personal growth and life reflections
          </p>
        </a>

        <a href="/blog?category=travel" class="group rounded-lg border border-bg-tertiary bg-bg-primary p-8 shadow-sm hover:border-accent-gold/50 transition-all hover:shadow-md">
          <h3 class="text-2xl font-serif font-semibold text-text-primary group-hover:text-accent-gold transition-colors">
            Travel
          </h3>
          <p class="mt-3 text-sm text-text-secondary">
            Travel stories and global experiences
          </p>
        </a>

        <a href="/blog?category=solo-dev" class="group rounded-lg border border-bg-tertiary bg-bg-primary p-8 shadow-sm hover:border-accent-gold/50 transition-all hover:shadow-md">
          <h3 class="text-2xl font-serif font-semibold text-text-primary group-hover:text-accent-gold transition-colors">
            Solo Dev
          </h3>
          <p class="mt-3 text-sm text-text-secondary">
            Development logs and behind the scenes
          </p>
        </a>
      </div>

      <div class="mt-10 text-center">
        <a href="/blog" class="text-accent-blue hover:text-accent-blue/80 transition-colors">
          View all posts →
        </a>
      </div>
    </div>
  </section>

  <!-- Contact Section -->
  <section class="border-t border-bg-tertiary px-4 py-20 sm:px-6 lg:px-8" id="contact">
    <div class="mx-auto max-w-4xl text-center">
      <h2 class="text-3xl font-bold font-serif tracking-tight text-text-primary">Get In Touch</h2>
      <p class="mt-4 text-lg text-text-secondary">
        Feel free to reach out via email or connect on social media.
      </p>
      <div class="mt-8 flex justify-center space-x-8">
        <a href="mailto:hello@example.com" class="text-text-secondary hover:text-accent-blue transition-colors">
          hello@example.com
        </a>
        <a href="https://github.com/yourusername" target="_blank" rel="noopener" class="text-text-secondary hover:text-accent-blue transition-colors">
          GitHub
        </a>
      </div>
    </div>
  </section>
</BaseLayout>
EOF
    print_success "Created complete Home page (overwritten)"
}

create_blog_listing_page() {
    cat > "$PROJECT_DIR_ABS/src/pages/blog.astro" << 'EOF'
---
import BaseLayout from '../layouts/BaseLayout.astro';
import { getCollection } from 'astro:content';

// Get all blog posts
const allPosts = await getCollection('blog');

// Sort by date (newest first)
const sortedPosts = allPosts.sort((a, b) =>
  b.data.date.valueOf() - a.data.date.valueOf()
);

// Get URL params for category filtering
const urlParams = Astro.url.searchParams;
const categoryFilter = urlParams.get('category');

// Filter posts by category
const displayPosts = categoryFilter
  ? sortedPosts.filter(post => post.data.category === categoryFilter)
  : sortedPosts;
---

<BaseLayout title="MySite - Blog">
  <div class="px-4 py-16 sm:px-6 lg:px-8">
    <div class="mx-auto max-w-4xl">
      <h1 class="text-4xl font-bold font-serif tracking-tight text-text-primary">Blog</h1>

      <!-- Category Filter -->
      <div class="mt-10 flex flex-wrap gap-3">
        <a
          href="/blog"
          class={!categoryFilter ? 'rounded-md bg-accent-blue px-5 py-2 text-bg-primary' : 'rounded-md border border-bg-tertiary px-5 py-2 text-text-secondary hover:border-accent-gold/50 hover:text-text-primary transition-all'}
        >
          All
        </a>
        <a
          href="/blog?category=life-story"
          class={categoryFilter === 'life-story' ? 'rounded-md bg-accent-blue px-5 py-2 text-bg-primary' : 'rounded-md border border-bg-tertiary px-5 py-2 text-text-secondary hover:border-accent-gold/50 hover:text-text-primary transition-all'}
        >
          Life Story
        </a>
        <a
          href="/blog?category=travel"
          class={categoryFilter === 'travel' ? 'rounded-md bg-accent-blue px-5 py-2 text-bg-primary' : 'rounded-md border border-bg-tertiary px-5 py-2 text-text-secondary hover:border-accent-gold/50 hover:text-text-primary transition-all'}
        >
          Travel
        </a>
        <a
          href="/blog?category=solo-dev"
          class={categoryFilter === 'solo-dev' ? 'rounded-md bg-accent-blue px-5 py-2 text-bg-primary' : 'rounded-md border border-bg-tertiary px-5 py-2 text-text-secondary hover:border-accent-gold/50 hover:text-text-primary transition-all'}
        >
          Solo Dev
        </a>
      </div>

      <!-- Blog Posts -->
      <div class="mt-12 space-y-10">
        {displayPosts.length === 0 ? (
          <p class="text-center text-text-muted">No posts found in this category yet.</p>
        ) : (
          displayPosts.map((post) => (
            <article class="border-b border-bg-tertiary pb-10 last:border-0">
              <h2 class="text-2xl font-bold font-serif text-text-primary">
                <a href={`/blog/${post.slug}`} class="hover:text-accent-blue transition-colors">
                  {post.data.title}
                </a>
              </h2>
              <p class="mt-2 text-sm text-text-muted">
                {post.data.date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })} · {post.data.category.replace('-', ' ').replace(/\b\w/g, l => l.toUpperCase())}
              </p>
              <p class="mt-3 text-text-secondary">
                {post.data.description}
              </p>
              <a href={`/blog/${post.slug}`} class="mt-4 inline-block text-accent-blue hover:text-accent-blue/80 transition-colors">
                Read more →
              </a>
            </article>
          ))
        )}
      </div>
    </div>
  </div>
</BaseLayout>
EOF
    print_success "Created blog listing page"
}

create_blog_detail_page() {
    cat > "$PROJECT_DIR_ABS/src/pages/blog/[...slug].astro" << 'EOF'
---
import { getCollection } from 'astro:content';
import BaseLayout from '../../layouts/BaseLayout.astro';

export async function getStaticPaths() {
  const posts = await getCollection('blog');
  return posts.map(post => ({
    params: { slug: post.slug },
    props: { post },
  }));
}

const { post } = Astro.props;
const { Content } = await post.render();
---

<BaseLayout title={`${post.data.title} - MySite`}>
  <article class="px-4 py-16 sm:px-6 lg:px-8">
    <div class="mx-auto max-w-3xl">
      <!-- Back link -->
      <a href="/blog" class="text-accent-blue hover:text-accent-blue/80 transition-colors">
        ← Back to Blog
      </a>

      <!-- Header -->
      <header class="mt-8">
        <h1 class="text-4xl font-bold font-serif tracking-tight text-text-primary sm:text-5xl">
          {post.data.title}
        </h1>
        <div class="mt-4 flex flex-wrap gap-4 text-sm text-text-muted">
          <time>{post.data.date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}</time>
          <span>·</span>
          <span>{post.data.category.replace('-', ' ').replace(/\b\w/g, l => l.toUpperCase())}</span>
        </div>
        <p class="mt-6 text-xl text-text-secondary">
          {post.data.description}
        </p>
      </header>

      <!-- Content -->
      <div class="mt-12 prose prose-invert prose-lg max-w-none">
        <Content />
      </div>
    </div>
  </article>
</BaseLayout>
EOF
    print_success "Created blog detail page"
}

create_sample_posts() {
    # Life Story sample
    cat > "$PROJECT_DIR_ABS/src/content/blog/life-story/sample-post-one.md" << 'EOF'
---
title: "Getting Started with Your New Website"
description: "Welcome to your new Astro website. Here's how to get started."
date: 2026-01-01
lang: en
category: life-story
---

Welcome to your new website! This is a sample post to help you get started with creating content.

## Getting Started

To add your own posts:

1. Create new `.md` files in `src/content/blog/` directories
2. Add frontmatter with title, description, date, and category
3. Write your content in Markdown
4. Run `npm run dev` to see your changes

## Customization

- Edit `src/content/config.ts` to modify categories
- Update the blog pages to match your content structure
- Replace sample content with your own

Happy blogging!
EOF

    # Travel sample
    cat > "$PROJECT_DIR_ABS/src/content/blog/travel/sample-post-two.md" << 'EOF'
---
title: "Your Second Sample Post"
description: "Another sample post to demonstrate the blog functionality."
date: 2026-01-15
lang: en
category: travel
---

This is another sample post to show how the blog system works.

## Features

The blog system includes:

- Category filtering
- Clean, readable typography
- Responsive design
- Markdown support

Replace this with your own content!
EOF

    # Solo Dev sample
    cat > "$PROJECT_DIR_ABS/src/content/blog/solo-dev/sample-post-three.md" << 'EOF'
---
title: "Your Third Sample Post"
description: "The final sample post demonstrating the blog layout."
date: 2026-01-20
lang: en
category: solo-dev
---

This is the third and final sample post included with the template.

## Next Steps

Now that you have the structure set up:

1. Delete or modify these sample posts
2. Add your own content
3. Customize the design to match your brand
4. Publish your site

Enjoy building your new website!
EOF

    print_success "Created sample blog posts (3 posts)"
}

################################################################################
# Main Script
################################################################################

print_header "🚀 Tailwind Layout System Setup"

# Validate project
validate_project

# Create Content Collections config
print_step "Creating Content Collections configuration..."
create_content_config

# Create blog directories
print_step "Creating blog directory structure..."
create_blog_directories

# Create complete Home page
print_step "Creating complete Home page..."
create_home_page

# Create Blog listing page
print_step "Creating Blog listing page..."
create_blog_listing_page

# Create Blog detail page
print_step "Creating Blog detail page..."
create_blog_detail_page

# Create sample posts
print_step "Creating sample blog posts..."
create_sample_posts

# Done!
print_header "✅ Layout system added successfully!"

echo -e "📂 ${GREEN}Project:${NC} $PROJECT_DIR_ABS"
echo ""
echo -e "${BLUE}🚀 Next steps:${NC}"
echo "   cd $PROJECT_DIR"
if [ "$PROJECT_DIR" != "." ]; then
    echo "   cd $PROJECT_DIR"
fi
echo "   npm run dev"
echo ""
echo "   Then open ${YELLOW}http://localhost:4321${NC}"
echo ""
