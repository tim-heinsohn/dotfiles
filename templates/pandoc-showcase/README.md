# Pandoc LaTeX Template Showcase for A4 Prints

## Quick Reference

| Template | Use Case | GitHub Stars | Last Update |
|----------|----------|--------------|-------------|
| **Eisvogel** | Modern thesis/papers | 4.2k | May 2025 |
| **Academic Pandoc** | General academic writing | 1.8k | Apr 2025 |
| **PhD Thesis** | Complete PhD thesis | 2.1k | May 2025 |
| **IEEE** | Conference papers | 800 | Apr 2025 |
| **Clean Thesis** | University thesis | 1.5k | May 2025 |

## Installation

```bash
# Install templates locally
mkdir -p ~/.local/share/pandoc/templates

# Eisvogel (most popular)
wget https://github.com/Wandmalfarbe/pandoc-latex-template/releases/latest/download/eisvogel.latex -O ~/.local/share/pandoc/templates/eisvogel.latex

# Academic Pandoc
git clone https://github.com/maehr/academic-pandoc-template.git ~/templates/academic-pandoc

# PhD Thesis
git clone https://github.com/tompollard/phd_thesis_markdown.git ~/templates/phd-thesis
```

## Usage Examples

### 1. Eisvogel (Modern & Clean)

```yaml
---
title: "Sample Document"
author: "Your Name"
date: "2025-08-17"
toc: true
numbersections: true
papersize: a4
geometry: "margin=2.5cm"
fontsize: 11pt
linestretch: 1.15
fontfamily: libertine
---
```

### 2. Academic Article

```yaml
---
title: "Research Paper Title"
author: "Author Name"
institute: "University Name"
keywords: [pandoc, latex, template]
abstract: |
  This is the abstract text that will appear on the first page.
papersize: a4
geometry: "margin=3cm"
classoption: [a4paper, 11pt]
---
```

### 3. IEEE Conference Paper

```yaml
---
documentclass: IEEEtran
classoption: [conference, a4paper]
title: "Paper Title"
author: "Author Name"
institute: "Affiliation"
---
```

## Quick Start Commands

```bash
# Check installed templates
ls -la ~/.local/share/pandoc/templates/
ls -la /usr/share/pandoc/data/templates/
find ~/.local/share/pandoc/templates/ -name "*.latex" -o -name "*.html" | head -10

# List system data files
pandoc --print-default-data-file=templates/default.latex | head -5

# Basic Eisvogel
echo "# Hello World" | pandoc --template eisvogel -o hello.pdf

# With custom YAML
cat > doc.md << 'EOF'
---
title: "My Document"
author: "Me"
date: "2025-08-17"
toc: true
papersize: a4
---

# Introduction
This is a sample document.
EOF

pandoc doc.md --template eisvogel -o doc.pdf

# IEEE format
pandoc paper.md --template ieee -o paper.pdf
```

## Template Features Comparison

| Feature | Eisvogel | Academic | PhD Thesis | IEEE |
|---------|----------|----------|------------|------|
| A4 default | ✅ | ✅ | ✅ | ✅ |
| Code highlighting | ✅ | ✅ | ✅ | ✅ |
| Bibliography | ✅ | ✅ | ✅ | ✅ |
| Tables/Figures | ✅ | ✅ | ✅ | ✅ |
| Appendices | ✅ | ✅ | ✅ | ❌ |
| Front matter | ❌ | ✅ | ✅ | ❌ |
| Custom fonts | ✅ | ✅ | ✅ | ❌ |

## URLs for Template Showcases

- **Eisvogel Gallery**: https://pandoc-templates.org/template/eisvogel/
- **Academic Pandoc Examples**: https://github.com/maehr/academic-pandoc-template/tree/main/examples
- **PhD Thesis Samples**: https://github.com/tompollard/phd_thesis_markdown/tree/master/output