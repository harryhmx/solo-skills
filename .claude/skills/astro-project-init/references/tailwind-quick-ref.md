# Tailwind CSS Quick Reference

Quick reference for Tailwind CSS utility classes used in Hepmad project.

## Container & Spacing

```html
<!-- Max width container -->
<div class="mx-auto max-w-4xl">...</div>

<!-- Padding -->
<div class="px-4 py-8">...</div>
<!-- sm: px-4 sm:px-6 lg:px-8 -->

<!-- Margin -->
<div class="mt-4 mb-8">...</div>
```

## Typography

```html
<!-- Headings (serif font for brand consistency) -->
<h1 class="text-3xl font-bold font-serif">...</h1>
<h2 class="text-2xl font-semibold font-serif">...</h2>

<!-- Body text -->
<p class="text-lg text-text-secondary">...</p>
<p class="text-sm text-text-muted">...</p>
```

## Colors

```html
<!-- Text colors -->
<p class="text-text-primary">...</p>
<p class="text-text-secondary">...</p>
<p class="text-accent-blue">...</p>

<!-- Background colors -->
<div class="bg-bg-primary">...</div>
<div class="bg-bg-secondary">...</div>
```

## Borders

```html
<div class="border border-bg-tertiary">...</div>
<div class="border-t border-bg-tertiary">...</div>
```

## Flexbox & Grid

```html
<!-- Flexbox -->
<div class="flex justify-between">...</div>
<div class="flex items-center space-x-6">...</div>

<!-- Grid -->
<div class="grid gap-6 sm:grid-cols-3">...</div>
```

## Responsive Design

```html
<!-- Mobile-first approach -->
<div class="text-center md:text-left">
  Centered on mobile, left-aligned on desktop
</div>

<!-- Conditional rendering -->
<div class="hidden md:block">Hidden on mobile</div>
```

## Hover States

```html
<a href="#" class="text-text-secondary hover:text-text-primary">...</a>
<a href="#" class="hover:text-accent-blue">...</a>
<a href="#" class="hover:text-accent-gold">...</a>
```

## Rounded Corners & Shadows

```html
<div class="rounded-lg shadow-sm">...</div>
<div class="rounded-md shadow-md">...</div>
```

## Hepmad Custom Colors (Late Night Flight Dark Theme)

Defined in `tailwind.config.mjs`:

```js
colors: {
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
}
```

## Common Patterns

### Button

```html
<button class="rounded-md bg-accent-blue px-6 py-3 font-semibold text-bg-primary shadow-sm hover:bg-accent-blue/90">
  Click Me
</button>
```

### Card

```html
<div class="rounded-lg border border-bg-tertiary bg-bg-primary p-6 shadow-sm hover:border-accent-gold/50 hover:shadow-md transition-all">
  <h3 class="text-xl font-serif font-semibold text-text-primary">Title</h3>
  <p class="mt-2 text-text-secondary">Description</p>
</div>
```

### Section

```html
<section class="border-t border-bg-tertiary bg-bg-secondary px-4 py-16 sm:px-6 lg:px-8">
  <div class="mx-auto max-w-4xl">
    <!-- Content -->
  </div>
</section>
```

## Links

- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Tailwind CSS Cheat Sheet](https://tailwindcomponents.com/cheatsheet/)
