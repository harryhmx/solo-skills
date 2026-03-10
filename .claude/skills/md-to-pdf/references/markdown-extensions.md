# Python-Markdown Extensions Reference

## Overview

Python-Markdown is a reliable and efficient Markdown parser with a variety of extensions for additional features.

## Official Documentation

- **GitHub**: https://github.com/Python-Markdown/markdown
- **Documentation**: https://python-markdown.github.io/
- **Extensions**: https://python-markdown.github.io/extensions/

## Basic Usage

```python
import markdown

md = markdown.Markdown(extensions=['extra', 'codehilite'])
html = md.convert(markdown_text)
```

## Built-in Extensions

### 1. Tables (`tables`)

GitHub-style table syntax:

```markdown
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Cell 4   | Cell 5   | Cell 6   |
```

**Installation:**
```python
markdown.Markdown(extensions=['tables'])
```

### 2. Fenced Code Blocks (`fenced_code`)

Triple-backtick code blocks with language specification:

```markdown
```python
def hello():
    print("Hello, World!")
```
```

**Installation:**
```python
markdown.Markdown(extensions=['fenced_code'])
```

### 3. CodeHilite (`codehilite`)

Syntax highlighting for code blocks:

```markdown
::::python
def hello():
    print("Hello, World!")
::::
```

**Configuration:**
```python
markdown.Markdown(
    extensions=['codehilite'],
    extension_configs={
        'codehilite': {
            'linenums': False,
            'css_class': 'codehilite',
            'guess_lang': True
        }
    }
)
```

### 4. Table of Contents (`toc`)

Auto-generated table of contents:

```markdown
[TOC]

# Header 1
Content...

# Header 2
Content...
```

**Configuration:**
```python
markdown.Markdown(
    extensions=['toc'],
    extension_configs={
        'toc': {
            'permalink': True,
            'baselevel': 1,
            'title': 'Contents'
        }
    }
)
```

### 5. New Line to Break (`nl2br`)

Convert single newlines to `<br>` tags:

```python
markdown.Markdown(extensions=['nl2br'])
```

### 6. Sane Lists (`sane_lists`)

Better list parsing for mixed content:

```python
markdown.Markdown(extensions=['sane_lists'])
```

### 7. Attribute Lists (`attr_list`)

Add HTML attributes to elements:

```markdown
# Header {: #id .class }

 paragraph with **bold**{: .highlight } text
```

**Installation:**
```python
markdown.Markdown(extensions=['attr_list'])
```

## The `extra` Extension

The `extra` extension bundles several commonly used extensions:

- `abbr`
- `attr_list`
- `def_list`
- `fenced_code`
- `footnotes`
- `tables`
- `smart_strong`
- `codehilite` (with `guess_lang=False`)

```python
markdown.Markdown(extensions=['extra'])
```

## Recommended Configuration for PDF Generation

```python
import markdown

md = markdown.Markdown(
    extensions=[
        'tables',           # Table support
        'fenced_code',      # Triple-backtick blocks
        'codehilite',       # Syntax highlighting
        'toc',              # Table of contents
        'nl2br',            # Newline to <br>
        'sane_lists',       # Better list parsing
        'attr_list',        # HTML attributes
    ],
    extension_configs={
        'codehilite': {
            'linenums': False,
            'css_class': 'codehilite',
            'guess_lang': True,
        },
        'toc': {
            'permalink': False,
            'baselevel': 1,
        }
    }
)

html = md.convert(markdown_text)
```

## Extension Order

Extension order matters! Some extensions depend on others:

1. Load `nl2br` first if using it
2. Load `sane_lists` before other list-processing extensions
3. Load `toc` last (to capture all headers)

## Tips for PDF Conversion

1. **Use `fenced_code`** over `codehilite`'s `::::` syntax for better compatibility
2. **Disable line numbers** in code blocks for cleaner PDFs
3. **Use `attr_list`** to add page-break controls: `## Header {: style="page-break-before: always;" }`
4. **Enable `guess_lang`** in codehilite for automatic language detection

## Troubleshooting

### Tables not rendering

Make sure `tables` extension is enabled:
```python
extensions=['tables']
```

### Code highlighting not working

Install Pygments:
```bash
pip install pygments
```

### TOC not appearing

Make sure document has headers and `[TOC]` placeholder:
```markdown
[TOC]

# Header 1
Content...
```

## Resources

- Full extension list: https://python-markdown.github.io/extensions/
- Extension API: https://python-markdown.github.io/extension_api/
- Writing custom extensions: https://python-markdown.github.io/extension_api/
