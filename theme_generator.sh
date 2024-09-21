#!/bin/bash

# Script to create a custom Beamer theme with the specified theme name.
# Usage: ./create_beamer_theme.sh [ThemeName]
# If no ThemeName is provided, defaults to 'MyTheme'

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to display usage
usage() {
    echo "Usage: $0 [ThemeName]"
    echo "If no ThemeName is provided, defaults to 'MyTheme'."
}

# Check for help option
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
    exit 0
fi

# Assign theme name
THEME_NAME=${1:-MyTheme}

# Validate theme name (only letters and numbers)
if [[ ! "$THEME_NAME" =~ ^[A-Za-z0-9]+$ ]]; then
    echo "Error: ThemeName must contain only letters and numbers."
    exit 1
fi

# Define directory name
DIR_NAME="beamer-theme-${THEME_NAME}"

# Create directory structure
echo "Creating directory structure in ./${DIR_NAME}..."
mkdir -p "${DIR_NAME}"

# Function to create .sty files
create_sty_file() {
    FILE_PATH="${DIR_NAME}/$1"
    cat <<EOF > "${FILE_PATH}"
% $1
\ProvidesPackage{$2}

\usepackage{xcolor}

% Define Custom Colors
\definecolor{primary}{RGB}{0, 153, 204}      % Bright Cyan
\definecolor{secondary}{RGB}{0, 255, 255}    % Aqua
\definecolor{background}{RGB}{20, 20, 20}    % Dark background
\definecolor{textcolor}{RGB}{240, 240, 240}  % Light gray text
\definecolor{itemcolor}{RGB}{255, 255, 0}    % Yellow for items
\definecolor{alertcolor}{RGB}{255, 69, 0}    % OrangeRed for alerts
\definecolor{highlight}{RGB}{144, 238, 144}  % LightGreen for highlights

% Set Beamer Colors
\setbeamercolor{background canvas}{bg=background}
\setbeamercolor{normal text}{fg=textcolor}
\setbeamercolor{item}{fg=itemcolor}
\setbeamercolor{item projected}{bg=primary, fg=textcolor}
\setbeamercolor{alerted text}{fg=alertcolor}
\setbeamercolor{structure}{fg=secondary}

% Additional Color Settings
\setbeamercolor{section in toc}{fg=secondary}
\setbeamercolor{frametitle}{fg=primary}
\setbeamercolor{title}{fg=primary}
\setbeamercolor{author}{fg=primary}
\setbeamercolor{institute}{fg=primary}
\setbeamercolor{date}{fg=primary}
\setbeamercolor{block title}{bg=primary!80, fg=white}
\setbeamercolor{block body}{bg=background, fg=textcolor}
\setbeamercolor{block alerted title}{bg=alertcolor, fg=white}
\setbeamercolor{block alerted body}{bg=background, fg=textcolor}
EOF
    echo "Created $FILE_PATH"
}

# Function to create Inner Theme .sty
create_inner_theme() {
    FILE_PATH="${DIR_NAME}/$1"
    cat <<EOF > "${FILE_PATH}"
% $1
\ProvidesPackage{$2}

\usepackage{beamerthemesplit} % Base on an existing inner theme

% Customize itemize symbols
\setbeamertemplate{itemize item}{\color{itemcolor}$\blacktriangleright$}
\setbeamertemplate{itemize subitem}{\color{itemcolor}$\blacktriangleleft$}
\setbeamertemplate{itemize subsubitem}{\color{itemcolor}$\bullet$}

% Customize block titles
\setbeamertemplate{blocks}[default]
EOF
    echo "Created $FILE_PATH"
}

# Function to create Outer Theme .sty
create_outer_theme() {
    FILE_PATH="${DIR_NAME}/$1"
    cat <<EOF > "${FILE_PATH}"
% $1
\ProvidesPackage{$2}

\usepackage{beamerthemesplit} % Base on an existing outer theme

% Customize headline
\setbeamertemplate{headline}{
  \begin{beamercolorbox}[ht=2.5ex,dp=1.125ex]{section in head/foot}
    \hfill\insertsectionnavigationhorizontal{\paperwidth}{}{}
  \end{beamercolorbox}
}

% Customize footline
\setbeamertemplate{footline}{
  \leavevmode%
  \hbox{%
  \begin{beamercolorbox}[wd=.5\paperwidth,ht=2.5ex,dp=1.125ex,left]{author in head/foot}%
    \usebeamerfont{author in head/foot}\hspace*{2ex}\insertshortauthor
  \end{beamercolorbox}%
  \begin{beamercolorbox}[wd=.5\paperwidth,ht=2.5ex,dp=1.125ex,right]{date in head/foot}%
    \usebeamerfont{date in head/foot}\insertshortdate{}\hspace*{2ex}
  \end{beamercolorbox}}%
  \vskip0pt%
}
EOF
    echo "Created $FILE_PATH"
}

# Function to create Main Theme .sty
create_main_theme() {
    FILE_PATH="${DIR_NAME}/$1"
    cat <<EOF > "${FILE_PATH}"
% $1
\ProvidesPackage{$2}

\usepackage{beamerthemesplit} % Base on an existing outer theme
\usepackage{beamercolortheme${THEME_NAME}}
\usepackage{beamerinnertheme${THEME_NAME}} % If created
\usepackage{beameroutertheme${THEME_NAME}} % If created

% Custom Commands
\newcommand{\highlighttext}[1]{\textcolor{highlight}{#1}}
\newcommand{\alerttext}[1]{\alert{#1}}
EOF
    echo "Created $FILE_PATH"
}

# Create Color Theme
create_sty_file "beamercolortheme${THEME_NAME}.sty" "beamercolortheme${THEME_NAME}"

# Create Inner Theme (Optional)
create_inner_theme "beamerinnertheme${THEME_NAME}.sty" "beamerinnertheme${THEME_NAME}"

# Create Outer Theme (Optional)
create_outer_theme "beameroutertheme${THEME_NAME}.sty" "beameroutertheme${THEME_NAME}"

# Create Main Theme
create_main_theme "beamertheme${THEME_NAME}.sty" "beamertheme${THEME_NAME}"
