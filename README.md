# Beamer Theme: <ThemeName>

This directory contains the custom Beamer theme `<ThemeName>`, which includes color, inner, outer, and main theme definitions.

## Directory Structure

```bash
<ThemeDirectory>/
├── beamercolortheme<ThemeName>.sty
├── beamerinnertheme<ThemeName>.sty
├── beameroutertheme<ThemeName>.sty
├── beamertheme<ThemeName>.sty
└── README.md
```

## Installation

1. **Locate Your TeX Directory:**

   - **User-specific Installation:**
     ```bash
     ~/texmf/tex/latex/beamer/themes/<ThemeName>/
     ```

   - **System-wide Installation:**
     ```bash
     /usr/local/texlive/texmf-local/tex/latex/beamer/themes/<ThemeName>/
     ```

2. **Move Theme Files:**
   - Copy all `.sty` files to the theme directory created above.

3. **Refresh LaTeX’s File Database:**
   - **TeX Live:**
     ```bash
     texhash
     ```
   - **MiKTeX:**
     Use the MiKTeX Settings utility to refresh the file name database.

## Usage

In your Beamer presentation, set the theme by adding the following lines to the preamble:

```latex
\documentclass{beamer}

% Use your custom theme
\usetheme{<ThemeName>}

% Additional packages if needed
\usepackage{hyperref} % For clickable links

% Title and Author Information
\title{\highlighttext{Your Presentation Title}}
\author{\highlighttext{Your Name}}
\institute{\highlighttext{Your Institute}}
\date{\today}

\begin{document}

\begin{frame}
    \titlepage
\end{frame}

% Add more frames here

\end{document}
```

## Custom Commands

- **\highlighttext{...}:** Applies a light green color to the text.
- **\alerttext{...}:** Highlights the text with an alert color (OrangeRed).

## Customization

Feel free to modify the `.sty` files to better suit your presentation needs. You can adjust colors, fonts, and layout elements as desired.

## Troubleshooting

- **Theme Not Found Error:**
  - Ensure that the theme files are placed in the correct directory.
  - Refresh LaTeX’s file database.
  - Check for typos in the theme name.

- **Custom Commands Not Recognized:**
  - Verify that the theme is correctly loaded using `\usetheme{<ThemeName>}`.
  - Ensure that custom commands are defined in `beamertheme<ThemeName>.sty`.

## License

This theme is provided as-is. Feel free to use and modify it for your presentations.

---

Happy Presenting!
