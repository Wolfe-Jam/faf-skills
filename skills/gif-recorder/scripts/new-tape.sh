#!/bin/bash
# Generate a new VHS tape file from template
# Usage: new-tape.sh <name> [theme] [size]

NAME="${1:-demo}"
THEME="${2:-Dracula}"
SIZE="${3:-standard}"

# Size presets
case "$SIZE" in
  compact)
    WIDTH=600
    HEIGHT=350
    ;;
  detailed)
    WIDTH=900
    HEIGHT=500
    ;;
  wide)
    WIDTH=1000
    HEIGHT=400
    ;;
  *)
    WIDTH=800
    HEIGHT=400
    ;;
esac

cat << EOF
# ${NAME} Demo
# Created: $(date +%Y-%m-%d)

Output "${NAME}.gif"

Set FontSize 18
Set Width ${WIDTH}
Set Height ${HEIGHT}
Set Theme "${THEME}"
Set Padding 20
Set TypingSpeed 40ms

# Title
Type "# ${NAME} Demo"
Enter
Sleep 1s

# Your commands here
Type "echo 'Hello from ${NAME}'"
Enter
Sleep 2s

# Outro
Type "# Done!"
Enter
Sleep 2s
EOF
