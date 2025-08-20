# Pandoc LaTeX Template Showcase - A4 Prints

## ✅ Ready-to-Use Templates

### 1. **Basic Template** (Working Sample)
- **File**: `basic-example.md` + `basic-sample.pdf`
- **Use**: Universal A4 documents
- **Features**: Clean typography, numbered sections, code highlighting
- **Command**: `pandoc basic-example.md -o output.pdf`

### 2. **UTF-8 Template** (XeLaTeX)
- **File**: `utf8-example.md` + `utf8-sample.pdf`
- **Use**: Unicode content, special characters
- **Command**: `pandoc utf8-example.md --pdf-engine=xelatex -o output.pdf`

## 🎯 Top Template URLs & Resources

### Primary Templates
1. **Eisvogel** - Modern, clean design
   - GitHub: https://github.com/Wandmalfarbe/pandoc-latex-template
   - Gallery: https://pandoc-templates.org/template/eisvogel/

2. **Academic Pandoc** - University papers
   - GitHub: https://github.com/maehr/academic-pandoc-template

3. **PhD Thesis** - Complete thesis structure
   - GitHub: https://github.com/tompollard/phd_thesis_markdown

4. **IEEE Conference** - Conference papers
   - GitHub: https://github.com/stsewd/ieee-pandoc-template

### Template Collections
- **Awesome Pandoc Templates**: https://github.com/topics/latex-template
- **Pandoc-Scholar**: https://github.com/pandoc-scholar/pandoc-scholar
- **Clean Thesis**: https://github.com/cagix/pandoc-thesis

## 🚀 Quick Start

```bash
# Install this showcase
cd ~/dotfiles/templates/pandoc-showcase
./install-templates.sh

# Generate sample PDF
pandoc basic-example.md -o my-document.pdf

# Use with Eisvogel template (after installation)
pandoc my-document.md --template eisvogel -o output.pdf
```

## 📊 Template Comparison

| Feature | Basic | Eisvogel | Academic | IEEE |
|---------|--------|----------|----------|------|
| A4 default | ✅ | ✅ | ✅ | ✅ |
| Code highlighting | ✅ | ✅ | ✅ | ✅ |
| Bibliography | ✅ | ✅ | ✅ | ✅ |
| Unicode support | ✅ | ✅ | ✅ | ✅ |
| Custom fonts | ❌ | ✅ | ✅ | ❌ |
| Front matter | ❌ | ✅ | ✅ | ✅ |
| Print-ready | ✅ | ✅ | ✅ | ✅ |

## 🎨 Customization Examples

### YAML Front Matter
```yaml
---
title: "My Document"
author: "Author Name"
date: "2025-08-17"
toc: true
papersize: a4
geometry: "margin=2.5cm"
fontsize: 11pt
linestretch: 1.15
---
```

### Advanced Options
```yaml
---
# Layout
papersize: a4
geometry: "top=2cm,bottom=2cm,left=2.5cm,right=2.5cm"
fontsize: 12pt

# Typography
fontfamily: libertine
linestretch: 1.3

# Colors
linkcolor: blue
toccolor: black

# Elements
toc: true
numbersections: true
listings: true
---
```

## 📂 Files Included

- `README.md` - This overview
- `basic-example.md` - Simple working template
- `basic-sample.pdf` - Generated sample PDF
- `utf8-example.md` - UTF-8 compatible template
- `utf8-sample.pdf` - UTF-8 sample PDF
- `install-templates.sh` - Template installation script
- `eisvogel-example.md` - Eisvogel template example

## 🔗 Online Resources

### Template Showcases
- **Pandoc Templates Gallery**: https://pandoc-templates.org/
- **Eisvogel Examples**: https://github.com/Wandmalfarbe/pandoc-latex-template/tree/master/examples
- **Academic Template Examples**: https://github.com/maehr/academic-pandoc-template/tree/main/examples

### Documentation
- **Pandoc Manual**: https://pandoc.org/MANUAL.html
- **LaTeX Templates**: https://www.latextemplates.com/
- **CTAN**: https://ctan.org/