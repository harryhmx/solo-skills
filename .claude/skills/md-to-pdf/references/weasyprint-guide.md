# WeasyPrint Reference Guide

## Overview

WeasyPrint is a visual rendering engine for HTML and CSS that can export to PDF. It aims to support web standards for printing.

## Official Documentation

- **Website**: https://weasyprint.org/
- **GitHub**: https://github.com/Kozea/WeasyPrint
- **Documentation**: https://weasyprint.readthedocs.io/

## Installation

```bash
pip install weasyprint
```

### System Dependencies

**Ubuntu/Debian:**
```bash
sudo apt install python3-dev libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0
```

**macOS:**
```bash
brew install pango
```

**Windows:**
No additional dependencies required.

## Basic Usage

```python
from weasyprint import HTML, CSS

# From string
HTML(string='<h1>Hello</h1>').write_pdf('output.pdf')

# From file
HTML(filename='input.html').write_pdf('output.pdf')

# From URL
HTML(url='https://example.com').write_pdf('output.pdf')

# With custom CSS
HTML(string='<h1>Hello</h1>').write_pdf(
    'output.pdf',
    stylesheets=[CSS(string='h1 { color: red; }')]
)
```

## CSS Support

WeasyPrint supports most of CSS 2.1 and parts of CSS 3:

### Paged Media

```css
@page {
    size: A4;
    margin: 2cm;
}

@page :first {
    margin-top: 5cm;
}

@page :left {
    margin-left: 3cm;
}
```

### Page Breaks

```css
.page-break-before {
    page-break-before: always;
}

.no-break {
    page-break-inside: avoid;
}
```

### Headers and Footers

```css
@page {
    @top-center {
        content: "Chapter " counter(chapter);
    }
    @bottom-right {
        content: "Page " counter(page);
    }
}
```

## Font Configuration

WeasyPrint automatically detects system fonts. For Chinese fonts:

```python
from weasyprint import HTML

css = '''
@font-face {
    font-family: 'ChineseFont';
    src: local('WenQuanYi Zen Hei'),
         local('WenQuanYi Micro Hei');
}

body {
    font-family: 'ChineseFont', sans-serif;
}
'''

HTML(string='<p>中文内容</p>').write_pdf(
    'output.pdf',
    stylesheets=[CSS(string=css)]
)
```

## Table Support

```css
table {
    border-collapse: collapse;
    width: 100%;
}

th {
    background-color: #3498db;
    color: white;
    padding: 8px;
}

td {
    border: 1px solid #ddd;
    padding: 8px;
}
```

## Common Issues

### Chinese Fonts Not Rendering

Ensure fonts are installed on the system:

```bash
# Check available fonts
fc-list :lang=zh

# Install fonts (Ubuntu)
sudo apt install fonts-wqy-zenhei fonts-wqy-microhei
```

### Images Not Loading

Use absolute paths or base64 encoding:

```html
<!-- Absolute path -->
<img src="/home/user/project/image.png">

<!-- Base64 encoding (recommended for portability) -->
<img src="data:image/png;base64,iVBORw0KGgo...">
```

## Performance Tips

1. **Reuse CSS objects**: Create CSS once, use multiple times
2. **Use page-break control**: Avoid orphaned content
3. **Optimize images**: Resize before embedding
4. **Cache results**: For repeated conversions

## Limitations

- No JavaScript execution
- Limited support for CSS Grid (partial)
- No support for CSS custom properties (variables) in older versions
- Floats have limited support
- Fixed positioning works differently than browsers

## Comparison with Alternatives

| Feature | WeasyPrint | pdfkit | reportlab |
|---------|-----------|--------|-----------|
| CSS Support | Full CSS | Full CSS | Limited |
| Python API | Yes | Yes | Yes |
| External Deps | None | wkhtmltopdf | None |
| Chinese Fonts | Auto | Manual | Manual |
| Active Dev | Yes | Low | Yes |

## Resources

- WeasyPrint Tutorial: https://weasyprint.org/posts/tutorial/
- CSS Paged Media spec: https://www.w3.org/TR/css-page-3/
- PDF generation best practices: https://weasyprint.org/tips/
