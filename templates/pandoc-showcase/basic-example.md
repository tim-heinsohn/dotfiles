---
title: "Basic A4 Document Template"
author: "Author Name"
date: "2025-08-17"
toc: true
papersize: a4
geometry: "margin=2cm"
fontsize: 12pt
---

# Introduction

This is a basic A4 document template that works with standard LaTeX fonts.

## Document Features

- A4 paper size optimized for printing
- Professional 2cm margins
- Clean typography with 12pt font
- Table of contents
- Numbered sections
- Code highlighting
- Mathematical notation

## Section 1: Typography

### Subsection 1.1

This document demonstrates how to create a clean, professional-looking PDF from Markdown using Pandoc and LaTeX.

### Subsection 1.2

You can include **bold text**, *italic text*, and `inline code` seamlessly.

## Section 2: Code Examples

```python
def fibonacci(n):
    """Generate the first n Fibonacci numbers"""
    a, b = 0, 1
    result = []
    for i in range(n):
        result.append(a)
        a, b = b, a + b
    return result

# Usage
print(fibonacci(10))
```

## Section 3: Mathematics

### Basic Equations

The quadratic formula:

$$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$

### Advanced Mathematics

Euler's identity:

$$e^{i\pi} + 1 = 0$$

## Section 4: Tables

| Feature | Status | Notes |
|:--------|:-------|:------|
| Headers | Yes | Numbered automatically |
| Lists | Yes | Bullet and numbered |
| Code | Yes | Syntax highlighting |
| Math | Yes | LaTeX equations |
| Tables | Yes | Professional formatting |

## Section 5: Lists

### Ordered List

1. Install required packages
2. Write your markdown content
3. Run pandoc to generate PDF
4. Print your document

### Unordered List

- Clean, professional appearance
- Print-ready formatting
- Easy customization via YAML
- Cross-platform compatibility

## Conclusion

This template provides a solid foundation for creating professional A4 documents with Pandoc and LaTeX.