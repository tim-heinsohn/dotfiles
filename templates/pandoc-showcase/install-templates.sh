#!/bin/bash
# Install popular Pandoc LaTeX templates for A4 prints

set -e

echo "📦 Installing Pandoc LaTeX templates..."

# Create template directory
TEMPLATE_DIR="$HOME/.local/share/pandoc/templates"
mkdir -p "$TEMPLATE_DIR"

# Create showcase directory
SHOWCASE_DIR="$HOME/dotfiles/templates/pandoc-showcase"
mkdir -p "$SHOWCASE_DIR"

echo "🎯 Installing Eisvogel template..."
if ! [ -f "$TEMPLATE_DIR/eisvogel.latex" ]; then
    wget -q https://github.com/Wandmalfarbe/pandoc-latex-template/releases/latest/download/eisvogel.latex -O "$TEMPLATE_DIR/eisvogel.latex"
    echo "   ✅ Eisvogel template installed"
else
    echo "   ✓ Eisvogel template already exists"
fi

echo "📚 Installing Academic Pandoc template..."
ACADEMIC_DIR="$SHOWCASE_DIR/academic-pandoc"
if ! [ -d "$ACADEMIC_DIR" ]; then
    git clone https://github.com/maehr/academic-pandoc-template.git "$ACADEMIC_DIR" --depth 1
    echo "   ✅ Academic template cloned"
else
    echo "   ✓ Academic template already exists"
fi

echo "🎓 Installing PhD Thesis template..."
PHD_DIR="$SHOWCASE_DIR/phd-thesis"
if ! [ -d "$PHD_DIR" ]; then
    git clone https://github.com/tompollard/phd_thesis_markdown.git "$PHD_DIR" --depth 1
    echo "   ✅ PhD thesis template cloned"
else
    echo "   ✓ PhD thesis template already exists"
fi

echo "📄 Installing IEEE template..."
IEEE_DIR="$SHOWCASE_DIR/ieee-template"
if ! [ -d "$IEEE_DIR" ]; then
    git clone https://github.com/stsewd/ieee-pandoc-template.git "$IEEE_DIR" --depth 1
    echo "   ✅ IEEE template cloned"
else
    echo "   ✓ IEEE template already exists"
fi

echo "🎉 Templates installed successfully!"
echo ""
echo "📋 Check installed templates:"
echo "   ls -la ~/.local/share/pandoc/templates/"
echo "   find ~/.local/share/pandoc/templates/ -name '*.latex' -o -name '*.html' | head -10"
echo ""
echo "📖 Usage examples:"
echo "   pandoc document.md --template eisvogel -o output.pdf"
echo "   pandoc document.md --template $SHOWCASE_DIR/academic-pandoc/template.latex -o output.pdf"
echo ""
echo "📂 Templates location:"
echo "   - User templates: $TEMPLATE_DIR"
echo "   - Showcase examples: $SHOWCASE_DIR"
echo ""
echo "🔍 List system templates:"
echo "   ls -la ~/.local/share/pandoc/templates/"
echo "   ls -la /usr/share/pandoc/data/templates/"
echo ""
echo "🔍 Try: cd $SHOWCASE_DIR && pandoc eisvogel-example.md --template eisvogel -o example.pdf"