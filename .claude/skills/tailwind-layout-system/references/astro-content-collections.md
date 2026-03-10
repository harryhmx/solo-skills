# Astro Content Collections Reference

Quick reference for using Astro Content Collections for blog functionality.

## Basic Setup

### Configuration (`astro.config.mjs`)

```js
import { defineConfig } from 'astro/config';

export default defineConfig({
  // Content collections are enabled by default in Astro 4.x
});
```

### Collection Structure

```
src/content/
├── blog/
│   ├── life-story/
│   │   └── post.md
│   ├── travel/
│   │   └── post.md
│   └── solo-dev/
│       └── post.md
└── config.ts
```

### Collection Schema (`src/content/config.ts`)

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

## Using Collections

### Get All Posts

```astro
---
const allPosts = await Astro.glob('../content/blog/**/*.md');
---

{allPosts.map(post => (
  <a href={post.url}>{post.title}</a>
))}
```

### Get Specific Collection

```astro
---
import { getCollection } from 'astro:content';

const allPosts = await getCollection('blog');
// Sort by date
const sortedPosts = allPosts.sort((a, b) =>
  b.data.date.valueOf() - a.data.date.valueOf()
);
---
```

### Filter by Category

```astro
---
const lifeStoryPosts = allPosts.filter(post =>
  post.data.category === 'life-story'
);
---
```

## Frontmatter Example

```markdown
---
title: "My Post Title"
description: "A brief description"
date: 2026-01-01
lang: en
category: life-story
---

# Post Content Here
```

## Links

- [Official Documentation](https://docs.astro.build/en/guides/content-collections/)
