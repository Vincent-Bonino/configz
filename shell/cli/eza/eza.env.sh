# TODO: See eza theme
export EZA_ICONS_AUTO=1
export EZA_ICON_SPACING=2

# Custom coloration
CUSTOM_EZA_COLORS="uu=0:gu=0"                               # No coloration for my user
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:uR=1;31:gR=1;31"    # Root files in bold red
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:nb=92:ub=92"        # File size under 1KB in bright green
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:nk=32:uk=32"        # File size under 1MB in green
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:nm=32:um=32"        # File size under 1GB in green
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:ng=91:ug=91"        # File size under 1TB in bright red
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:nt=1;92:ut=1;92"    # File size above 1TB in bold bright red

## Generic project files in purple
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:CHANGELOG.md=38;5;171"
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:README.md=38;5;171"
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:CONTRIBUTING.md=38;5;171"

## Per extension
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:*.log=38;5;250"     # Log files in shade of grey

## Docker files in bright blue
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:*Dockerfile*=94"
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:*dockerfile*=94"
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:.dockerignore*=94"

## Git files in orange
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:.git*=38;5;130"

## Python files in bright green
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:pyproject.toml=92"
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:setup.py=92"
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:.python-version=2;92"  # dimmed
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:__init__.py=2;92"  # dimmed
CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:__pycache__=2;92"  # dimmed

# mkdir -p /tmp/eza/colors
# for i in $(seq -w 0 255); do
#     CUSTOM_EZA_COLORS="${CUSTOM_EZA_COLORS}:*.${i}=38;5;${i}"
#     touch "/tmp/eza/colors/col.${i}"
# done

# Finaly, use this value
export EZA_COLORS="$CUSTOM_EZA_COLORS"
