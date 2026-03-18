---
name: image-stitch
description: "Stitch multiple images together vertically or horizontally. Use when combining multiple images into a single composite image."
author: Claude
version: "1.0.0"
---

# Image Stitch

Stitch multiple images together into a single composite image.

## Usage

```bash
source ~/venv/hepmad/bin/activate
python ~/projects/huang/.claude/skills/image-stitch/scripts/stitch.py [options] <output_file> <input_files...>
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `--direction` | `vertical` | Stitch direction: `vertical` or `horizontal` |
| `--spacing` | `0` | Pixels between images |
| `--align` | `center` | Alignment for perpendicular axis: `left`, `center`, `right` (vertical) or `top`, `center`, `bottom` (horizontal) |
| `--background` | `#FFFFFF` | Background color for spacing area |

## Examples

```bash
# Vertical stitch (default)
python stitch.py output.jpg img1.jpg img2.jpg img3.jpg

# Horizontal stitch
python stitch.py --direction horizontal output.jpg img1.jpg img2.jpg

# Vertical with spacing and alignment
python stitch.py --spacing 10 --align left output.jpg img1.jpg img2.jpg
```

## Requirements

- Python 3.x
- Pillow (PIL): `pip install Pillow`
