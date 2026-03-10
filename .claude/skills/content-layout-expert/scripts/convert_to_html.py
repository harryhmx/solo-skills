#!/usr/bin/env python3
"""
Convert Markdown files to HTML (format for WeChat Official Account / Xiumi).
Supports basic markdown syntax with images.
"""

import sys
from pathlib import Path
import markdown

# For PDF support (optional)
try:
    from weasyprint import HTML
    WEASYPRINT_SUPPORT = True
except ImportError:
    WEASYPRINT_SUPPORT = False


def markdown_to_html(md_path: Path, add_styling: bool = True) -> str:
    """Convert markdown file to HTML string."""
    # Read markdown content
    with open(md_path, 'r', encoding='utf-8') as f:
        md_content = f.read()

    # Configure markdown extensions
    md = markdown.Markdown(extensions=[
        'tables',
        'fenced_code',
        'nl2br',
        'sane_lists',
        'extra'
    ])

    # Convert to HTML
    html_content = md.convert(md_content)

    # Wrap with HTML template
    if add_styling:
        html_template = """<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title}</title>
    <style>
        body {{
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", sans-serif;
            line-height: 1.8;
            color: #333;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }}
        h1, h2, h3, h4, h5, h6 {{
            margin-top: 1.5em;
            margin-bottom: 0.8em;
            font-weight: 600;
        }}
        h1 {{ font-size: 2em; border-bottom: 2px solid #eee; padding-bottom: 0.3em; }}
        h2 {{ font-size: 1.5em; border-bottom: 1px solid #eee; padding-bottom: 0.3em; }}
        h3 {{ font-size: 1.25em; }}
        p {{ margin-bottom: 1em; }}
        strong {{ font-weight: 600; color: #000; }}
        em {{ font-style: italic; }}
        img {{
            max-width: 100%;
            height: auto;
            display: block;
            margin: 1.5em auto;
            border-radius: 4px;
        }}
        table {{
            border-collapse: collapse;
            width: 100%;
            margin: 1.5em 0;
        }}
        th, td {{
            border: 1px solid #ddd;
            padding: 8px 12px;
            text-align: left;
        }}
        th {{ background-color: #f5f5f5; font-weight: 600; }}
        code {{
            background-color: #f4f4f4;
            padding: 2px 6px;
            border-radius: 3px;
            font-family: "Monaco", "Menlo", monospace;
            font-size: 0.9em;
        }}
        pre {{
            background-color: #f4f4f4;
            padding: 12px;
            border-radius: 4px;
            overflow-x: auto;
        }}
        pre code {{
            background-color: transparent;
            padding: 0;
        }}
        blockquote {{
            border-left: 4px solid #ddd;
            margin: 1.5em 0;
            padding-left: 1em;
            color: #666;
        }}
        ul, ol {{ padding-left: 2em; }}
        a {{ color: #1890ff; text-decoration: none; }}
        a:hover {{ text-decoration: underline; }}
    </style>
</head>
<body>
{content}
</body>
</html>"""
        title = md_path.stem
        return html_template.format(title=title, content=html_content)
    else:
        return html_content


def main() -> None:
    """Main entry point."""
    if len(sys.argv) < 2:
        print("Usage: python convert_to_html.py <path-to-markdown-file>")
        sys.exit(1)

    file_path = sys.argv[1]
    path = Path(file_path)

    if not path.exists():
        print(f"Error: File not found: {file_path}")
        sys.exit(1)

    if path.suffix.lower() != '.md':
        print(f"Error: Expected .md file, got: {path.suffix}")
        sys.exit(1)

    print(f"Converting Markdown to HTML: {file_path}")

    # Convert to HTML
    html_content = markdown_to_html(path, add_styling=True)

    # Save HTML file
    html_path = path.with_suffix('.html')
    with open(html_path, 'w', encoding='utf-8') as f:
        f.write(html_content)

    print(f"✓ HTML saved: {html_path}")


if __name__ == '__main__':
    main()
