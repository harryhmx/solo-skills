# Pygments Syntax Highlighting Reference

## Overview

Pygments is a generic syntax highlighter for general use in all kinds of software such as forum systems, wikis or other applications that need to prettify source code.

## Official Documentation

- **Website**: https://pygments.org/
- **GitHub**: https://github.com/pygments/pygments
- **Documentation**: https://pygments.org/docs/

## Installation

```bash
pip install pygments
```

## Basic Usage

### Command Line

```bash
# Highlight a file
pygmentize -o output.html input.py

# Specify lexer
pygmentize -l python -o output.html input.py

# Use a specific style
pygmentize -f html -S monokai > style.css
```

### Python API

```python
from pygments import highlight
from pygments.lexers import PythonLexer
from pygments.formatters import HtmlFormatter

code = 'def hello(): print("world")'
lexer = PythonLexer()
formatter = HtmlFormatter(style='monokai')

result = highlight(code, lexer, formatter)
```

## Integration with Markdown

### With Python-Markdown

```python
import markdown

md = markdown.Markdown(
    extensions=['codehilite'],
    extension_configs={
        'codehilite': {
            'linenums': False,
            'css_class': 'codehilite',
        }
    }
)

html = md.render('```python\ndef hello():\n    pass\n```')
```

### Manual Integration

```python
from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import HtmlFormatter

def highlight_code(code, lang):
    lexer = get_lexer_by_name(lang, stripall=True)
    formatter = HtmlFormatter(
        style='github-dark',
        cssclass='codehilite',
        linenos=False
    )
    return highlight(code, lexer, formatter)
```

## Available Styles

Pygments comes with many built-in styles:

### Light Themes
- `default` - Classic Pygments style
- `pastie` - Pastie style
- `borland` - Borland IDE style
- `friendly` - Friendly grayscale
- `manni` - Manni's style

### Dark Themes
- `monokai` - Monokai (popular)
- `github-dark` - GitHub Dark (recommended)
- `vim` - Vim style
- `vs` - Visual Studio style
- `rrt` - RRT style

### Colorful Themes
- `colorful` - Very colorful
- `tango` - Tango style
- `autumn` - Autumn colors
- `bw` - Black and white

## Getting CSS for a Style

```python
from pygments.formatters import HtmlFormatter

# Get CSS for a specific style
formatter = HtmlFormatter(style='github-dark')
css = formatter.get_style_defs('.codehilite')

print(css)
```

Or via command line:
```bash
pygmentize -f html -S github-dark -a .codehilite > pygments.css
```

## Supported Languages

Pygments supports hundreds of languages. Common ones:

| Language | Lexer Name |
|----------|------------|
| Python | `python` |
| JavaScript | `javascript` or `js` |
| TypeScript | `typescript` or `ts` |
| HTML | `html` |
| CSS | `css` |
| JSON | `json` |
| Bash | `bash` or `sh` |
| SQL | `sql` |
| Java | `java` |
| C/C++ | `c`, `cpp` |
| Go | `go` |
| Rust | `rust` |
| PHP | `php` |
| Ruby | `ruby` |
| Swift | `swift` |
| Kotlin | `kotlin` |
| Dart | `dart` |
| YAML | `yaml` |
| XML | `xml` |

## Line Numbers

Enable line numbers:

```python
formatter = HtmlFormatter(
    style='github-dark',
    cssclass='codehilite',
    linenos=True  # Enable line numbers
)
```

## CSS Styling for WeasyPrint

When generating PDFs with WeasyPrint:

```css
/* Pygments GitHub Dark theme for PDF */
.codehilite {
    background-color: #282c34;
    color: #abb2bf;
    padding: 12pt;
    border-radius: 5px;
    overflow-x: auto;
    page-break-inside: avoid;
}

.codehilite .hll { background-color: #3e4451 }
.codehilite .c { color: #5c6370; font-style: italic }
.codehilite .err { color: #f48771 }
.codehilite .k { color: #c678dd }
.codehilite .l { color: #e5c07b }
.codehilite .n { color: #e06c75 }
.codehilite .o { color: #56b6c2 }
.codehilite .p { color: #abb2bf }
.codehilite .cm { color: #5c6370; font-style: italic }
.codehilite .cp { color: #5c6370; font-weight: bold }
.codehilite .c1 { color: #5c6370; font-style: italic }
.codehilite .cs { color: #5c6370; font-style: italic }
.codehilite .gd { color: #f48771 }
.codehilite .ge { font-style: italic }
.codehilite .gh { color: #e5c07b; font-weight: bold }
.codehilite .gi { color: #98c379 }
.codehilite .gp { color: #61afef; font-weight: bold }
.codehilite .gs { font-weight: bold }
.codehilite .gu { color: #c678dd; font-weight: bold }
.codehilite .kc { color: #c678dd }
.codehilite .kd { color: #c678dd }
.codehilite .kn { color: #c678dd }
.codehilite .kp { color: #c678dd }
.codehilite .kr { color: #c678dd }
.codehilite .kt { color: #e5c07b }
.codehilite .ld { color: #98c379 }
.codehilite .m { color: #d19a66 }
.codehilite .s { color: #98c379 }
.codehilite .na { color: #d19a66 }
.codehilite .nb { color: #e5c07b }
.codehilite .nc { color: #61afef; font-weight: bold }
.codehilite .no { color: #e5c07b }
.codehilite .nd { color: #c678dd }
.codehilite .ni { color: #e06c75 }
.codehilite .ne { color: #e06c75 }
.codehilite .nf { color: #61afef }
.codehilite .nl { color: #e5c07b }
.codehilite .nn { color: #e06c75 }
.codehilite .nx { color: #e06c75 }
.codehilite .py { color: #e06c75 }
.codehilite .nt { color: #c678dd }
.codehilite .nv { color: #e06c75 }
.codehilite .ow { color: #56b6c2 }
.codehilite .w { color: #abb2bf }
.codehilite .mf { color: #d19a66 }
.codehilite .mh { color: #d19a66 }
.codehilite .mi { color: #d19a66 }
.codehilite .mo { color: #d19a66 }
.codehilite .sb { color: #98c379 }
.codehilite .sc { color: #abb2bf }
.codehilite .sd { color: #5c6370; font-style: italic }
.codehilite .s2 { color: #98c379 }
.codehilite .se { color: #d19a66 }
.codehilite .sh { color: #98c379 }
.codehilite .si { color: #d19a66 }
.codehilite .sx { color: #98c379 }
.codehilite .sr { color: #d19a66 }
.codehilite .s1 { color: #98c379 }
.codehilite .ss { color: #98c379 }
.codehilite .bp { color: #e5c07b }
.codehilite .vc { color: #e06c75 }
.codehilite .vg { color: #e06c75 }
.codehilite .vi { color: #e06c75 }
.codehilite .il { color: #d19a66 }
```

## Tips for PDF Generation

1. **Use dark themes** for code blocks in PDFs (better contrast)
2. **Disable line numbers** by default (cleaner look)
3. **Set page-break-inside: avoid** to prevent orphaned code
4. **Use `github-dark` style** - popular and well-tested

## Auto-detect Language

```python
from pygments.lexers import guess_lexer, guess_lexer_for_filename

# Auto-detect from code
lexer = guess_lexer('def hello(): pass')

# Auto-detect from filename
lexer = guess_lexer_for_filename('script.py', 'content')
```

## Resources

- All supported lexers: https://pygments.org/docs/lexers/
- All available styles: https://pygments.org/styles/
- Formatter documentation: https://pygments.org/docs/formatters/
