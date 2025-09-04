Utilities

- Location: `~/dotfiles/utils` with executables in `~/dotfiles/utils/bin`.
- Ensure `~/dotfiles/utils/bin` is in your `PATH` (or symlink as needed).

Split A3 PDF into 6 A4 pages

- `split_a3_to_a4`:
  - Split a single-page A3 PDF into 6 A4 pages with equal scaling.
  - Uses `pdfinfo`, `convert` (ImageMagick), and `pdfunite`.
  - Default output folder: same directory as the source PDF.
  - Help: `split_a3_to_a4 -h`.

Examples

- Basic:
  - `split_a3_to_a4 "/path/to/Grundriss A3.pdf"`

- With margin and DPI:
  - `split_a3_to_a4 "/path/to/Grundriss A3.pdf" --margin-mm 15 --dpi 300`

- Custom output directory:
  - `split_a3_to_a4 "/path/to/Grundriss A3.pdf" --out-dir ~/Desktop`

- Dry-run (no files written):
  - `split_a3_to_a4 "/path/to/Grundriss A3.pdf" --dry-run`

fzf helper

- `split-a3-to-a4-fzf`:
  - Pick a PDF via `fzf` and run the splitter.
  - Options:
    - `--search-dir DIR` (default: current dir)
    - `--margin-mm N` (default: 20)
    - `--dpi N` (default: 300)
    - `--out-dir DIR` (default: source folder)
    - `--dry-run`
    - `-h|--help`

Examples

- Pick from a folder:
  - `split-a3-to-a4-fzf --search-dir ~/f.doc/Haus/Grundriss`

- Pick and write to Desktop:
  - `split-a3-to-a4-fzf --search-dir ~/f.doc/Haus/Grundriss --out-dir ~/Desktop`

