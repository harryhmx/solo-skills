#!/bin/bash

################################################################################
# Hepmad Astro Project Init Script
#
# Creates a Hepmad Astro project with Tailwind CSS and basic page scaffolding.
#
# Usage:
#   ./init.sh [project_name] [target_dir]
#
# Example:
#   ./init.sh hepmad ~/projects
################################################################################

set -e  # Exit on error

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
PROJECT_NAME=${1:-hepmad}
TARGET_DIR=${2:-.}

# Get absolute paths
TARGET_DIR_ABS=$(cd "$TARGET_DIR" && pwd)
PROJECT_PATH="$TARGET_DIR_ABS/$PROJECT_NAME"

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
# Main Functions
################################################################################

create_package_json() {
    cat > "$1/package.json" << 'EOF'
{
  "name": "PROJECT_NAME",
  "type": "module",
  "version": "0.0.1",
  "scripts": {
    "dev": "astro dev",
    "start": "astro dev",
    "build": "astro check && astro build",
    "preview": "astro preview",
    "astro": "astro"
  },
  "dependencies": {
    "astro": "^4.16.12",
    "@astrojs/tailwind": "^6.0.0",
    "tailwindcss": "^3.4.17"
  }
}
EOF
    # Replace PROJECT_NAME placeholder
    sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" "$1/package.json"
    print_success "Created package.json"
}

create_astro_config() {
    cat > "$1/astro.config.mjs" << 'EOF'
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

export default defineConfig({
  integrations: [tailwind()],
  site: 'https://hepmad.com',
});
EOF
    print_success "Created astro.config.mjs"
}

create_tailwind_config() {
    cat > "$1/tailwind.config.mjs" << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        // Late Night Flight - Dark Theme
        bg: {
          primary: '#0F1117',   // Main background - near black with blue tint
          secondary: '#1A1D27', // Card/section backgrounds
          tertiary: '#2A2E3D',  // Dividers
        },
        text: {
          primary: '#E8E6E1',   // Main text - off-white
          secondary: '#8B8FA8', // Secondary text - gray-blue
          muted: '#6B7280',     // Muted text
        },
        accent: {
          gold: '#C9A84C',      // Accent - warm gold
          blue: '#5B8FD4',      // Links/CTA - soft blue
        },
      },
      fontFamily: {
        serif: ['"Playfair Display"', 'serif'],
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
};
EOF
    print_success "Created tailwind.config.mjs (Late Night Flight dark theme)"
}

create_gitignore() {
    cat > "$1/.gitignore" << 'EOF'
# Node
node_modules/
dist/
.astro/

# Environment
.env
.env.*

# IDE
.vscode/
.idea/

# OS
.DS_Store
Thumbs.db
EOF
    print_success "Created .gitignore"
}

create_directory_structure() {
    mkdir -p "$1/src/components"
    mkdir -p "$1/src/layouts"
    mkdir -p "$1/src/pages"
    mkdir -p "$1/src/styles"
    mkdir -p "$1/public"
    print_success "Created directory structure"
}

create_navbar_component() {
    cat > "$1/src/components/Navbar.astro" << 'EOF'
---
---

<nav class="border-b border-bg-tertiary bg-bg-primary">
  <div class="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
    <div class="flex h-16 justify-between">
      <div class="flex">
        <a href="/" class="flex flex-shrink-0 items-center">
          <span class="text-xl font-bold font-serif text-text-primary">Hepmad</span>
        </a>
      </div>
      <div class="flex items-center space-x-8">
        <a href="/" class="text-text-secondary hover:text-text-primary transition-colors">Home</a>
        <a href="/blog" class="text-text-secondary hover:text-text-primary transition-colors">Blog</a>
      </div>
    </div>
  </div>
</nav>
EOF
    print_success "Created Navbar.astro"
}

create_footer_component() {
    cat > "$1/src/components/Footer.astro" << 'EOF'
---
---

<footer class="border-t border-bg-tertiary bg-bg-primary">
  <div class="mx-auto max-w-6xl px-4 py-8 sm:px-6 lg:px-8">
    <div class="flex flex-col items-center justify-between md:flex-row">
      <p class="text-sm text-text-muted">
        &copy; 2026 Hepmad. All rights reserved.
      </p>
      <div class="mt-4 flex space-x-6 md:mt-0">
        <a href="https://github.com/harryhmx" target="_blank" rel="noopener" class="text-text-muted hover:text-text-primary transition-colors">
          <span class="sr-only">GitHub</span>
          <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
            <path fill-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clip-rule="evenodd" />
          </svg>
        </a>
        <a href="mailto:hello@hepmad.com" class="text-text-muted hover:text-text-primary transition-colors">
          <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
          </svg>
        </a>
      </div>
    </div>
  </div>
</footer>
EOF
    print_success "Created Footer.astro"
}

create_base_layout() {
    cat > "$1/src/layouts/BaseLayout.astro" << 'EOF'
---
import Navbar from '../components/Navbar.astro';
import Footer from '../components/Footer.astro';

interface Props {
  title?: string;
}

const { title = 'Hepmad - Personal Brand' } = Astro.props;
---

<!doctype html>
  <html lang="en" class="dark">
    <head>
      <meta charset="UTF-8" />
      <meta name="description" content="Hepmad - Harry's personal brand website" />
      <meta name="viewport" content="width=device-width" />
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
      <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
      <meta name="generator" content={Astro.generator} />
      <title>{title}</title>
    </head>
    <body class="bg-bg-primary text-text-primary font-sans antialiased">
      <Navbar />
      <main>
        <slot />
      </main>
      <Footer />
    </body>
  </html>
EOF
    print_success "Created BaseLayout.astro"
}

create_home_page() {
    cat > "$1/src/pages/index.astro" << 'EOF'
---
import BaseLayout from '../layouts/BaseLayout.astro';
---

<BaseLayout title="Hepmad - Home">
  <!-- Hero Section -->
  <section class="min-h-[80vh] flex items-center justify-center border-b border-bg-tertiary px-4 sm:px-6 lg:px-8">
    <div class="mx-auto max-w-4xl text-center">
      <h1 class="text-5xl font-bold font-serif tracking-tight text-text-primary sm:text-6xl lg:text-7xl">
        Welcome to Hepmad
      </h1>
      <p class="mt-8 text-xl leading-relaxed text-text-secondary sm:text-2xl">
        Your personal brand website is ready. Run <code class="rounded bg-bg-tertiary px-2 py-1 text-accent-blue">npm run dev</code> to start building.
      </p>
      <div class="mt-12 text-text-muted">
        Use the tailwind-layout-system skill to add full page layouts.
      </div>
    </div>
  </section>
</BaseLayout>
EOF
    print_success "Created index.astro (Minimal home page)"
}

create_global_styles() {
    cat > "$1/src/styles/global.css" << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF
    print_success "Created global.css"
}

################################################################################
# Main Script
################################################################################

print_header "🚀 Hepmad Astro Project Initializer"

# Check if project already exists
if [ -d "$PROJECT_PATH" ]; then
    read -p "Directory $PROJECT_PATH already exists. Continue? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Aborted."
        exit 1
    fi
fi

# Create project directory
print_step "Creating Astro project: $PROJECT_NAME"
mkdir -p "$PROJECT_PATH"
print_success "Project directory: $PROJECT_PATH"

# Create configuration files
print_step "Creating configuration files..."
create_package_json "$PROJECT_PATH"
create_astro_config "$PROJECT_PATH"
create_tailwind_config "$PROJECT_PATH"
create_gitignore "$PROJECT_PATH"

# Create directory structure
print_step "Creating directory structure..."
create_directory_structure "$PROJECT_PATH"

# Create components
print_step "Creating components..."
create_navbar_component "$PROJECT_PATH"
create_footer_component "$PROJECT_PATH"

# Create layout
print_step "Creating layouts..."
create_base_layout "$PROJECT_PATH"

# Create pages
print_step "Creating pages..."
create_home_page "$PROJECT_PATH"

# Create styles
print_step "Creating global styles..."
create_global_styles "$PROJECT_PATH"

# Done!
print_header "✅ Project created successfully!"

echo -e "📂 ${GREEN}Location:${NC} $PROJECT_PATH"
echo ""
echo -e "${BLUE}🚀 Next steps:${NC}"
echo "   cd $PROJECT_NAME"
echo "   npm install"
echo "   npm run dev"
echo ""
echo "   Then open ${YELLOW}http://localhost:4321${NC}"
echo ""
