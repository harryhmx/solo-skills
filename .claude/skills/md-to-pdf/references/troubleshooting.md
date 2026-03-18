# Troubleshooting Guide

Common issues and solutions when using the md-to-pdf converter.

## Chinese Characters Show as Boxes (□□□)

**Cause:** Chinese fonts not installed on system

**Solution:**

```bash
# Linux/Ubuntu
sudo apt install fonts-wqy-zenhei fonts-wqy-microhei

# Verify installation
fc-list :lang=zh-cn
```

## WeasyPrint Installation Fails

**Cause:** Missing system dependencies

**Solution:**

```bash
sudo apt install python3-dev libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0
```

## Import Error: No Module Named 'weasyprint'

**Cause:** Not installed in virtual environment

**Solution:**

```bash
source ~/venv/hepmad/bin/activate  # Or your preferred virtual environment
pip install markdown weasyprint pygments
```

## PDF File Size Is Very Small (<30KB)

**Cause:** Chinese fonts not embedded (fallback to system fonts)

**Solution:** Install Chinese fonts (see [installation.md](installation.md)) and regenerate PDF

## Permission Denied Error

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
