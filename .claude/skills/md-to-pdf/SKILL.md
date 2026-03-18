---
name: md-to-pdf
description: "Convert Markdown files to PDF with Chinese font support using WeasyPrint. Use when converting Markdown documents (meeting notes, documentation, reports) to PDF, especially when Chinese characters are needed. Features: automatic font detection, syntax highlighting, table of contents, styled tables."
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
source ~/venv/hepmad/bin/activate  # Or your preferred virtual environment

# Convert with default settings
python .claude/skills/md-to-pdf/scripts/convert.py input.md

# Specify output path
python .claude/skills/md-to-pdf/scripts/convert.py input.md -o output.pdf
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
source ~/venv/hepmad/bin/activate  # Or your preferred virtual environment
pip install markdown weasyprint pygments
```

### System Dependencies & Installation

See [references/installation.md](references/installation.md) for:
- Linux (Ubuntu/Debian) system dependencies
- macOS setup
- Windows setup
- Chinese font installation

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
# Navigate to your project directory
cd /path/to/your/project
source ~/venv/hepmad/bin/activate  # Or your preferred virtual environment
python .claude/skills/md-to-pdf/scripts/convert.py meeting-summary.md

# Output: meeting-summary.pdf (in same directory)
```

## Troubleshooting

See [references/troubleshooting.md](references/troubleshooting.md) for:
- Chinese characters showing as boxes (□□□)
- WeasyPrint installation failures
- Import errors
- PDF file size issues
- Permission errors

## See Also

- [references/installation.md](references/installation.md) - Installation guide
- [references/troubleshooting.md](references/troubleshooting.md) - Common issues and solutions
- [references/weasyprint-guide.md](references/weasyprint-guide.md) - WeasyPrint documentation
- [references/pygments-guide.md](references/pygments-guide.md) - Syntax highlighting
- [references/markdown-extensions.md](references/markdown-extensions.md) - Supported Markdown extensions
