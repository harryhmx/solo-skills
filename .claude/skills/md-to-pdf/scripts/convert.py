#!/usr/bin/env python3
"""
Markdown to PDF Converter with Chinese Font Support
Uses WeasyPrint for reliable PDF generation with CSS styling
"""

import argparse
import os
import re
import sys
from pathlib import Path

try:
    import markdown
    from pygments.formatters import HtmlFormatter
except ImportError:
    print("Installing required packages...")
    import subprocess
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-q',
                          'markdown', 'weasyprint', 'pygments'])
    import markdown
    from pygments.formatters import HtmlFormatter

try:
    from weasyprint import HTML, CSS
except ImportError:
    print("Installing weasyprint...")
    import subprocess
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-q', 'weasyprint'])
    from weasyprint import HTML, CSS


def detect_chinese_fonts():
    """Detect available Chinese fonts on the system"""
    font_families = []

    # Linux fonts
    linux_fonts = [
        'WenQuanYi Zen Hei',
        'WenQuanYi Micro Hei',
        'Noto Sans CJK SC',
        'Noto Sans CJK TC',
        'Noto Sans CJK JP',
        'Droid Sans Fallback',
    ]

    # macOS fonts
    mac_fonts = [
        'PingFang SC',
        'PingFang TC',
        'STHeiti',
        'STSong',
    ]

    # Windows fonts
    windows_fonts = [
        'Microsoft YaHei',
        'SimHei',
        'SimSun',
    ]

    # Check platform and add appropriate fonts
    if sys.platform.startswith('linux'):
        font_families.extend(linux_fonts)
    elif sys.platform == 'darwin':
        font_families.extend(mac_fonts)
    elif sys.platform == 'win32':
        font_families.extend(windows_fonts)

    # Generic fallbacks
    font_families.extend(['sans-serif', 'Arial'])

    return font_families


def get_css_styles():
    """Generate CSS styles for the PDF"""
    chinese_fonts = detect_chinese_fonts()
    font_stack = ', '.join(f'"{f}"' for f in chinese_fonts)

    # Get syntax highlighting CSS
    formatter = HtmlFormatter(style='github-dark')
    code_css = formatter.get_style_defs('.codehilite')

    return f"""
        @page {{
            size: A4;
            margin: 2cm;
            @bottom-right {{
                content: counter(page);
                font-size: 10pt;
            }}
        }}

        body {{
            font-family: {font_stack};
            font-size: 11pt;
            line-height: 1.6;
            color: #333;
            max-width: 100%;
            margin: 0;
            padding: 0;
        }}

        h1 {{
            font-size: 24pt;
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 8px;
            margin-top: 24pt;
            margin-bottom: 16pt;
            page-break-after: avoid;
        }}

        h2 {{
            font-size: 18pt;
            color: #34495e;
            margin-top: 20pt;
            margin-bottom: 12pt;
            page-break-after: avoid;
        }}

        h3 {{
            font-size: 14pt;
            color: #7f8c8d;
            margin-top: 16pt;
            margin-bottom: 10pt;
            page-break-after: avoid;
        }}

        h4, h5, h6 {{
            font-size: 12pt;
            color: #7f8c8d;
            margin-top: 14pt;
            margin-bottom: 8pt;
            page-break-after: avoid;
        }}

        p {{
            margin-bottom: 8pt;
            text-align: justify;
        }}

        a {{
            color: #3498db;
            text-decoration: none;
        }}

        a:hover {{
            text-decoration: underline;
        }}

        ul, ol {{
            margin-left: 20pt;
            margin-bottom: 10pt;
        }}

        li {{
            margin-bottom: 4pt;
        }}

        blockquote {{
            border-left: 4px solid #bdc3c7;
            padding-left: 12pt;
            margin: 10pt 0;
            color: #7f8c8d;
            font-style: italic;
        }}

        code {{
            font-family: 'Courier New', monospace;
            background-color: #f4f4f4;
            padding: 2pt 4pt;
            border-radius: 3px;
            font-size: 10pt;
        }}

        pre {{
            background-color: #282c34;
            color: #abb2bf;
            padding: 12pt;
            border-radius: 5px;
            overflow-x: auto;
            page-break-inside: avoid;
        }}

        pre code {{
            background-color: transparent;
            padding: 0;
        }}

        table {{
            border-collapse: collapse;
            width: 100%;
            margin: 12pt 0;
            page-break-inside: avoid;
        }}

        th {{
            background-color: #3498db;
            color: white;
            padding: 8pt;
            text-align: left;
            font-weight: bold;
        }}

        td {{
            border: 1px solid #ddd;
            padding: 8pt;
        }}

        tr:nth-child(even) {{
            background-color: #f9f9f9;
        }}

        hr {{
            border: none;
            border-top: 1px solid #bdc3c7;
            margin: 16pt 0;
        }}

        strong {{
            font-weight: bold;
            color: #2c3e50;
        }}

        em {{
            font-style: italic;
        }}

        /* Syntax highlighting */
        {code_css}

        .codehilite {{
            border-radius: 5px;
        }}

        /* Page break control */
        h1, h2, h3, h4, h5, h6 {{
            page-break-after: avoid;
        }}

        table, blockquote, pre {{
            page-break-inside: avoid;
        }}

        /* Table of contents styling */
        .toc {{
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 16pt;
            margin-bottom: 20pt;
        }}

        .toc-title {{
            font-size: 16pt;
            font-weight: bold;
            margin-bottom: 12pt;
            color: #2c3e50;
        }}

        .toc ul {{
            list-style-type: none;
            margin-left: 0;
        }}

        .toc li {{
            margin-bottom: 6pt;
        }}

        .toc a {{
            color: #3498db;
            text-decoration: none;
        }}

        .toc a:hover {{
            text-decoration: underline;
        }}
    """


def markdown_to_html(md_content):
    """Convert Markdown to HTML with extensions"""
    md = markdown.Markdown(
        extensions=[
            'tables',
            'fenced_code',
            'codehilite',
            'toc',
            'nl2br',
            'sane_lists',
            'attr_list',
        ],
        extension_configs={
            'codehilite': {
                'linenums': False,
                'css_class': 'codehilite',
            }
        }
    )
    html_content = md.convert(md_content)

    # Wrap in proper HTML structure
    full_html = f"""
        <!DOCTYPE html>
        <html lang="zh-CN">
        <head>
            <meta charset="UTF-8">
            <title>Markdown Document</title>
        </head>
        <body>
            {html_content}
        </body>
        </html>
    """

    return full_html


def convert_to_pdf(input_file, output_file=None):
    """Convert Markdown file to PDF"""
    input_path = Path(input_file)

    if not input_path.exists():
        print(f"Error: File not found: {input_file}")
        return False

    # Determine output path
    if output_file is None:
        output_path = input_path.with_suffix('.pdf')
    else:
        output_path = Path(output_file)

    # Read Markdown content
    with open(input_path, 'r', encoding='utf-8') as f:
        md_content = f.read()

    print(f"Converting: {input_path}")
    print(f"Output: {output_path}")

    # Convert to HTML
    html_content = markdown_to_html(md_content)

    # Get CSS styles
    css_styles = get_css_styles()

    # Generate PDF
    try:
        HTML(string=html_content).write_pdf(
            output_path,
            stylesheets=[CSS(string=css_styles)]
        )
        print(f"✓ PDF created successfully: {output_path}")
        print(f"  File size: {output_path.stat().st_size / 1024:.1f} KB")
        return True
    except Exception as e:
        print(f"✗ Error creating PDF: {e}")
        print("\nTroubleshooting:")
        print("1. Install weasyprint: pip install weasyprint")
        print("2. Install system dependencies:")
        print("   sudo apt install python3-dev libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0")
        print("3. Install Chinese fonts:")
        print("   sudo apt install fonts-wqy-zenhei fonts-wqy-microhei")
        return False


def main():
    parser = argparse.ArgumentParser(
        description='Convert Markdown to PDF with Chinese font support'
    )
    parser.add_argument(
        'input',
        help='Input Markdown file'
    )
    parser.add_argument(
        '-o', '--output',
        help='Output PDF file (default: same as input with .pdf extension)'
    )

    args = parser.parse_args()

    success = convert_to_pdf(args.input, args.output)
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
