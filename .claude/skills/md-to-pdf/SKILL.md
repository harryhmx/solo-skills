---
name: md-to-pdf
description: "Convert Markdown files to PDF with Chinese font support using WeasyPrint"
author: "harryhmx"
version: "1.0.0"
---

# Markdown to PDF Converter

Convert Markdown files to beautifully formatted PDF documents with full Chinese font support.

## Use Cases

- Convert meeting notes, documentation, or reports from Markdown to PDF
- Generate PDFs with Chinese characters properly rendered
- Create professional documents with tables, headers, lists, and code blocks

## Input

- **Markdown file** (`.md`) - The source document to convert
- **Output path** (optional) - Where to save the PDF (default: same directory as input)

## Output

- **PDF file** - Formatted document with:
  - Proper Chinese font rendering
  - Tables, headers, lists, code blocks
  - Clean, professional styling
  - Page numbers
  - Syntax highlighting for code blocks

## How to Use

### Basic Usage

```bash
# Activate virtual environment first (required)
source ~/venv/hepmad/bin/activate

# Convert with default settings
python /home/harry/projects/hepmad/.claude/skills/md-to-pdf/scripts/convert.py input.md

# Specify output path
python /home/harry/projects/hepmad/.claude/skills/md-to-pdf/scripts/convert.py input.md -o output.pdf
```

### Via AI Assistant

Simply ask: *"Convert this markdown file to PDF: /path/to/file.md"*

## Scripts

### `convert.py`

Main conversion script that:
1. Reads the Markdown file
2. Converts to HTML using Python-Markdown with extensions
3. Applies CSS styling with Chinese font support
4. Generates PDF using WeasyPrint
5. Handles Chinese fonts automatically

**Features:**
- Automatic Chinese font detection (Linux/macOS/Windows)
- Syntax highlighting for code blocks (Pygments)
- Table of contents support
- Page break optimization for tables and code blocks

## Dependencies

### Python Packages

```bash
source ~/venv/hepmad/bin/activate
pip install markdown weasyprint pygments
```

### System Dependencies

**Linux (Ubuntu/Debian):**

```bash
# Core dependencies for WeasyPrint
sudo apt install python3-dev libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0

# Chinese fonts (REQUIRED for Chinese character display)
sudo apt install fonts-wqy-zenhei fonts-wqy-microhei
```

**macOS:**

```bash
# Chinese fonts are built-in (PingFang, STHeiti)
brew install python3
pip3 install markdown weasyprint pygments
```

**Windows:**

```bash
# Chinese fonts are built-in (Microsoft YaHei)
pip install markdown weasyprint pygments
```

## Features

| Feature | Status | Notes |
|---------|--------|-------|
| Chinese font support | ✅ Full support | Auto-detects system fonts |
| Headers (h1-h6) | ✅ | Styled with page-break control |
| Tables | ✅ | Styled with alternating row colors |
| Lists (ordered/unordered) | ✅ | Proper indentation |
| Code blocks with syntax highlighting | ✅ | GitHub Dark theme |
| Bold/italic/inline code | ✅ | Standard Markdown |
| Horizontal rules | ✅ | Styled separators |
| Custom styling via CSS | ✅ | Fully customizable |
| Page numbers | ✅ | Bottom-right corner |
| Table of contents | ✅ | Via `[TOC]` in Markdown |

## Example

```bash
# Convert a meeting summary
cd /home/harry/projects/hepmad/demo/rbh/ela-260302
source ~/venv/hepmad/bin/activate
python /home/harry/projects/hepmad/.claude/skills/md-to-pdf/scripts/convert.py meeting-summary.md

# Output: meeting-summary.pdf (in same directory)
```

## Markdown Extensions Supported

| Extension | Description |
|-----------|-------------|
| `tables` | GitHub-style tables |
| `fenced_code` | Triple-backtick code blocks |
| `codehilite` | Syntax highlighting |
| `toc` | Table of contents (`[TOC]`) |
| `nl2br` | Newline to `<br>` |
| `sane_lists` | Better list parsing |
| `attr_list` | Attributes on elements |

## Why WeasyPrint?

| Library | Chinese Support | CSS Support | Ease of Use | External Deps |
|---------|----------------|-------------|-------------|---------------|
| **WeasyPrint** | ✅ Excellent | ✅ Full CSS | ✅ Easy | ❌ None (Pure Python) |
| reportlab | ⚠️ Complex (manual font registration) | ❌ Limited | ⚠️ Complex | ❌ None |
| pdfkit | ⚠️ Depends on wkhtmltopdf | ✅ Full CSS | ✅ Easy | ✅ wkhtmltopdf binary |

**WeasyPrint advantages:**
- Pure Python - no external binaries required
- Full CSS3 support for beautiful styling
- Automatic font detection on all platforms
- Active development and good documentation

## CSS Styling

The generated PDF includes professional styling:
- **Colors**: Blue (#3498db) for headers, Dark gray (#2c3e50) for text
- **Fonts**: Auto-detected Chinese fonts + sans-serif fallback
- **Code blocks**: GitHub Dark theme for syntax highlighting
- **Tables**: Blue headers with alternating row colors
- **Margins**: 2cm on all sides
- **Page breaks**: Optimized to avoid orphaned content

## Troubleshooting

### Chinese characters show as boxes (□□□)

**Cause:** Chinese fonts not installed on system

**Solution:**
```bash
# Linux/Ubuntu
sudo apt install fonts-wqy-zenhei fonts-wqy-microhei

# Verify installation
fc-list :lang=zh-cn
```

### WeasyPrint installation fails

**Cause:** Missing system dependencies

**Solution:**
```bash
sudo apt install python3-dev libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0
```

### Import error: No module named 'weasyprint'

**Cause:** Not installed in virtual environment

**Solution:**
```bash
source ~/venv/hepmad/bin/activate
pip install markdown weasyprint pygments
```

### PDF file size is very small (<30KB)

**Cause:** Chinese fonts not embedded (fallback to system fonts)

**Solution:** Install Chinese fonts (see above) and regenerate PDF

### Permission denied error

**Cause:** Output directory not writable

**Solution:** Check write permissions or specify a writable output path:
```bash
python convert.py input.md -o /tmp/output.pdf
```

## Notes

- Always activate virtual environment before running the script
- Output PDF is saved in the same directory as the input Markdown file (unless specified)
- Font selection is automatic with intelligent fallbacks
- For best Chinese rendering, WQY fonts are recommended on Linux
- Code blocks use GitHub Dark theme for syntax highlighting

## See Also

- `references/` - Documentation for WeasyPrint, Markdown, and Python-Markdown
