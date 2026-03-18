# Installation Guide

System dependencies and installation instructions for md-to-pdf converter.

## Python Packages

```bash
source ~/venv/hepmad/bin/activate  # Or your preferred virtual environment
pip install markdown weasyprint pygments
```

## Linux (Ubuntu/Debian)

### Core Dependencies

```bash
sudo apt install python3-dev libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0
```

### Chinese Fonts (Required)

Chinese fonts are **REQUIRED** for proper Chinese character display.

```bash
sudo apt install fonts-wqy-zenhei fonts-wqy-microhei
```

### Verify Installation

```bash
fc-list :lang=zh-cn
```

## macOS

Chinese fonts are built-in (PingFang, STHeiti):

```bash
brew install python3
pip3 install markdown weasyprint pygments
```

## Windows

Chinese fonts are built-in (Microsoft YaHei):

```bash
pip install markdown weasyprint pygments
```

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
