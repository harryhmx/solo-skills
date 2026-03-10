#!/bin/bash

################################################################################
# Hepmad Tailwind Layout System Setup Script
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

<BaseLayout title="Hepmad - Home">
  <!-- Hero Section -->
  <section class="border-b border-bg-tertiary px-4 py-24 sm:py-32 sm:px-6 lg:px-8">
    <div class="mx-auto max-w-5xl text-center">
      <h1 class="text-5xl font-bold font-serif tracking-tight text-text-primary sm:text-7xl">
        Hi, I'm Harry
      </h1>
      <p class="mt-8 text-xl leading-relaxed text-text-secondary sm:text-2xl">
        Welcome to Hepmad — my personal brand website where I share my life stories,
        travel experiences, and solo development journey.
      </p>
      <div class="mt-12 flex items-center justify-center gap-x-6">
        <a href="/blog" class="rounded-md bg-accent-blue px-8 py-3 text-base font-semibold text-bg-primary shadow-sm hover:bg-accent-blue/90 transition-colors">
          Read My Blog
        </a>
      </div>
    </div>
  </section>

  <!-- About Section -->
  <section class="px-4 py-20 sm:px-6 lg:px-8" id="about">
    <div class="mx-auto max-w-4xl">
      <h2 class="text-3xl font-bold font-serif tracking-tight text-text-primary">About Me</h2>
      <p class="mt-6 text-lg leading-relaxed text-text-secondary">
        Hepmad comes from <strong>H</strong>arry + S<strong>ep</strong>tember + No<strong>mad</strong> — a reflection of my journey
        and aspirations. I'm building a life of freedom, exploration, and continuous growth.
      </p>

      <h3 class="mt-12 text-2xl font-semibold text-text-primary">Core Values</h3>
      <ul class="mt-6 space-y-3 text-text-secondary">
        <li>• <span class="text-accent-gold">Authenticity</span> — Living true to myself</li>
        <li>• <span class="text-accent-gold">Curiosity</span> — Always learning, always exploring</li>
        <li>• <span class="text-accent-gold">Freedom</span> — Designing a life of location independence</li>
        <li>• <span class="text-accent-gold">Creation</span> — Building things that matter</li>
        <li>• <span class="text-accent-gold">Connection</span> — Sharing stories and experiences</li>
      </ul>

      <h3 class="mt-12 text-2xl font-semibold text-text-primary">Timeline</h3>
      <div class="mt-6 space-y-3 text-text-secondary">
        <p><span class="text-accent-gold font-semibold">2006</span> — First major setback, learned resilience</p>
        <p><span class="text-accent-gold font-semibold">2007</span> — Moved to Thailand for university, began global journey</p>
        <p><span class="text-accent-gold font-semibold">2014</span> — Returned to China, started working in Shenzhen</p>
        <p><span class="text-accent-gold font-semibold">2015-2020</span> — Entrepreneurship attempts in travel industry</p>
        <p><span class="text-accent-gold font-semibold">2020-2025</span> — Pandemic abroad, exploration and partnerships</p>
        <p><span class="text-accent-gold font-semibold">2026</span> — Launching Hepmad, committing to the indie developer path</p>
      </div>
    </div>
  </section>

  <!-- Blog Section -->
  <section class="border-t border-bg-tertiary bg-bg-secondary px-4 py-20 sm:px-6 lg:px-8">
    <div class="mx-auto max-w-5xl">
      <h2 class="text-3xl font-bold font-serif tracking-tight text-text-primary">Latest from the Blog</h2>
      <p class="mt-4 text-lg text-text-secondary">
        I write about three main areas of my life.
      </p>

      <div class="mt-10 grid gap-6 sm:grid-cols-3">
        <a href="/blog?category=life-story" class="group rounded-lg border border-bg-tertiary bg-bg-primary p-8 shadow-sm hover:border-accent-gold/50 transition-all hover:shadow-md">
          <h3 class="text-2xl font-serif font-semibold text-text-primary group-hover:text-accent-gold transition-colors">
            Life Story
          </h3>
          <p class="mt-3 text-sm text-text-secondary">
            人生母本 — Personal growth and life reflections
          </p>
        </a>

        <a href="/blog?category=travel" class="group rounded-lg border border-bg-tertiary bg-bg-primary p-8 shadow-sm hover:border-accent-gold/50 transition-all hover:shadow-md">
          <h3 class="text-2xl font-serif font-semibold text-text-primary group-hover:text-accent-gold transition-colors">
            Travel
          </h3>
          <p class="mt-3 text-sm text-text-secondary">
            环球旅行 — Travel stories and global experiences
          </p>
        </a>

        <a href="/blog?category=solo-dev" class="group rounded-lg border border-bg-tertiary bg-bg-primary p-8 shadow-sm hover:border-accent-gold/50 transition-all hover:shadow-md">
          <h3 class="text-2xl font-serif font-semibold text-text-primary group-hover:text-accent-gold transition-colors">
            Solo Dev
          </h3>
          <p class="mt-3 text-sm text-text-secondary">
            独立开发 — Development logs and behind the scenes
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
        <a href="mailto:hello@hepmad.com" class="text-text-secondary hover:text-accent-blue transition-colors">
          hello@hepmad.com
        </a>
        <a href="https://github.com/harryhmx" target="_blank" rel="noopener" class="text-text-secondary hover:text-accent-blue transition-colors">
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

<BaseLayout title="Hepmad - Blog">
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

<BaseLayout title={`${post.data.title} - Hepmad`}>
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
    cat > "$PROJECT_DIR_ABS/src/content/blog/life-story/2026-the-year-i-decided-to-get-serious.md" << 'EOF'
---
title: "2026: The Year I Decided to Get Serious"
description: "Why I'm committing to the indie developer path and launching Hepmad."
date: 2026-01-01
lang: en
category: life-story
---

This is the year everything changes. After years of exploration, partnerships, and side projects, I'm finally going all-in on building my personal brand and solo development journey.

## Why Now?

Looking back at my timeline — from the setbacks in 2006 to moving to Thailand in 2007, from entrepreneurship attempts to surviving the pandemic abroad — I realize I've been preparing for this moment without knowing it.

## What to Expect

This blog will document:

- **Life Story** — Personal growth and reflections
- **Travel** — Experiences from living abroad
- **Solo Dev** — Behind the scenes of what I'm building

Let's see where this journey takes us.
EOF

    # Travel sample
    cat > "$PROJECT_DIR_ABS/src/content/blog/travel/surviving-pandemic-abroad.md" << 'EOF'
---
title: "Surviving the Pandemic Abroad: 18 Months in 5 Countries"
description: "How I navigated lockdowns, border closures, and uncertainty while living overseas."
date: 2026-01-15
lang: en
category: travel
---

When the pandemic hit, I wasn't home. I was abroad, with no clear path back and an uncertain future.

## The Journey

Over 18 months, I found myself in:

1. Thailand — where it all began
2. Nepal — mountains and lockdowns
3. UAE — desert waiting
4. Turkey — between continents
5. Multiple stops in between

## Lessons Learned

Living through a global pandemic while abroad taught me resilience, adaptability, and the value of community — wherever you find it.
EOF

    # Solo Dev sample
    cat > "$PROJECT_DIR_ABS/src/content/blog/solo-dev/why-i-chose-solo-dev-path.md" << 'EOF'
---
title: "Why I Chose the Solo Developer Path"
description: "My journey from employed developer to indie hacker, and why I'm never looking back."
date: 2026-01-20
lang: en
category: solo-dev
---

The question I get most often: "Isn't solo development lonely?"

The answer might surprise you.

## The Freedom to Build

When you work for someone else, you build their vision. When you're a solo developer, every line of code brings you closer to your own goals.

## It's Not About Being Alone

Solo development doesn't mean working in isolation. It means:

- Choosing your projects
- Setting your own pace
- Building directly with users
- Owning the outcome

## What I'm Working On

I'm building Agent Skills — reusable AI skill packages. And this website is just the beginning.
EOF

    print_success "Created sample blog posts (3 posts)"
}

################################################################################
# Main Script
################################################################################

print_header "🚀 Hepmad Tailwind Layout System Setup"

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
