---
name: gif-recorder
description: Create terminal GIF recordings using VHS (Charmbracelet). Use this skill when creating demos, tutorials, or showcases of CLI tools. Produces reproducible, styled terminal recordings from .tape script files.
---

# GIF Recorder Skill

Create professional terminal GIF recordings using VHS (Charmbracelet's Video Hardware Store).

## When to Use This Skill

Activate this skill when:
- Creating demos for CLI tools or commands
- Recording tutorials showing terminal workflows
- Building showcases for README files or documentation
- Producing shareable terminal animations
- Documenting command sequences with real output

## Prerequisites

Verify VHS is installed:
```bash
which vhs && vhs --version
```

If not installed:
```bash
brew install vhs
```

## VHS Fundamentals

### How VHS Works

VHS **executes real commands** - not simulations:
1. Spawns a real TTY terminal
2. Types characters with configurable timing
3. Runs actual commands and captures real output
4. Renders frames to GIF/MP4/WebM

### Tape File Structure

```tape
# Comment describing the recording
Output "filename.gif"

# Configuration
Set FontSize 18
Set Width 800
Set Height 400
Set Theme "Dracula"
Set Padding 20
Set TypingSpeed 40ms

# Commands
Type "echo 'Hello World'"
Enter
Sleep 2s
```

## FAF Demo Style Standards

### Recommended Settings

```tape
# Standard FAF Demo
Output "demo-name.gif"

Set FontSize 18
Set Width 800
Set Height 400
Set Theme "Dracula"
Set Padding 20
Set TypingSpeed 40ms
```

### Theme Options

| Theme | Use Case |
|-------|----------|
| `Dracula` | Primary - high contrast, professional |
| `Catppuccin Mocha` | Softer dark theme |
| `Catppuccin Latte` | Light mode demos |
| `TokyoNight` | Modern dark aesthetic |
| `Nord` | Minimalist Scandinavian |

### Dimension Presets

| Size | Dimensions | Use Case |
|------|------------|----------|
| Standard | 800x400 | Most demos |
| Detailed | 900x500 | Complex output |
| Compact | 600x350 | Quick showcases |
| Wide | 1000x400 | Long commands |

### Timing Guidelines

| Action | Duration |
|--------|----------|
| After command output | 2-3s (reading time) |
| Between sections | 1s |
| After title | 1s |
| End of demo | 2s |
| Total demo | 15-30s ideal |

## VHS Commands Reference

### Output
```tape
Output "filename.gif"      # GIF output
Output "filename.mp4"      # MP4 video
Output "filename.webm"     # WebM video
```

### Configuration
```tape
Set FontSize 18            # Font size in pixels
Set FontFamily "JetBrains Mono"
Set Width 800              # Terminal width
Set Height 400             # Terminal height
Set Theme "Dracula"        # Color theme
Set Padding 20             # Padding around terminal
Set TypingSpeed 40ms       # Delay between keystrokes
Set LineHeight 1.2         # Line height multiplier
Set LetterSpacing 0        # Letter spacing
Set Framerate 60           # GIF framerate
Set PlaybackSpeed 1.0      # Playback speed multiplier
```

### Actions
```tape
Type "command"             # Type text
Enter                      # Press Enter
Sleep 2s                   # Wait (s, ms)
Ctrl+C                     # Key combinations
Backspace 5                # Backspace N times
Left 3                     # Arrow key N times
Hide                       # Hide subsequent commands
Show                       # Show commands again
```

### Environment
```tape
Set Shell "zsh"            # Shell to use
Set Env "VAR" "value"      # Set environment variable
Source "~/.zshrc"          # Source a file
```

## Demo Templates

### Quick Command Demo
```tape
# Quick Demo - Single Command
Output "command-demo.gif"

Set FontSize 18
Set Width 800
Set Height 350
Set Theme "Dracula"
Set TypingSpeed 40ms

Type "faf score"
Enter
Sleep 3s
```

### Feature Showcase
```tape
# Feature Showcase - Multiple Steps
Output "feature-showcase.gif"

Set FontSize 18
Set Width 900
Set Height 500
Set Theme "Dracula"
Set Padding 20
Set TypingSpeed 35ms

# Title
Type "# Feature Name - Description"
Enter
Sleep 1s

# Setup
Type "cd /path/to/project"
Enter
Sleep 300ms

# Main action
Type "command --with-flags"
Enter
Sleep 3s

# Explanation
Type "# Key insight about the output"
Enter
Sleep 2s
```

### Before/After Comparison
```tape
# Before/After Demo
Output "before-after.gif"

Set FontSize 18
Set Width 900
Set Height 500
Set Theme "Dracula"
Set TypingSpeed 35ms

Type "# BEFORE"
Enter
Sleep 500ms

Type "old-command"
Enter
Sleep 2s

Type ""
Enter
Type "# AFTER (new feature)"
Enter
Sleep 500ms

Type "new-command"
Enter
Sleep 3s
```

## Workflow

### Creating a Demo

1. **Plan the demo** - What commands, what story?
2. **Create tape file**:
   ```bash
   vim demos/my-demo.tape
   ```
3. **Test locally** - Run commands manually first
4. **Record**:
   ```bash
   cd demos && vhs my-demo.tape
   ```
5. **Review** - Open GIF, check timing
6. **Iterate** - Adjust Sleep times, TypingSpeed
7. **Publish** (optional):
   ```bash
   vhs publish my-demo.gif
   ```

### File Organization

```
project/
└── demos/
    ├── DEMO-STYLE.md       # Style guide
    ├── feature-intro.tape  # Source files
    ├── feature-intro.gif   # Generated GIFs
    └── ...
```

### Naming Convention

```
{tool}-{feature}-{type}.tape
```

Examples:
- `faf-go-intro.tape`
- `faf-score-detailed.tape`
- `cli-install-quick.tape`

## Troubleshooting

### "Output path invalid"
Quote paths with special characters:
```tape
Output "my-demo.gif"  # Good
Output my-demo.gif    # Bad if has spaces/special chars
```

### Commands not running
Ensure commands work in a fresh shell - VHS uses a clean environment.

### Output too fast
Increase Sleep times after commands:
```tape
Type "command"
Enter
Sleep 3s  # Give time to read output
```

### Colors not showing
Some tools need `FORCE_COLOR=1`:
```tape
Set Env "FORCE_COLOR" "1"
```

### GIF too large
Reduce dimensions, framerate, or duration:
```tape
Set Width 700
Set Height 350
Set Framerate 30
```

## Publishing

### To vhs.charm.sh
```bash
vhs publish demo.gif
# Returns shareable URL
```

### To GitHub README
```markdown
![Demo](./demos/demo.gif)
```

### To social media
- Twitter/X: GIF embeds directly
- LinkedIn: Upload as video (convert to MP4)
- Discord: Direct GIF upload

## Quick Reference

```tape
# Minimal FAF Demo Template
Output "demo.gif"
Set FontSize 18
Set Width 800
Set Height 400
Set Theme "Dracula"
Set TypingSpeed 40ms

Type "faf command"
Enter
Sleep 3s
```

---

*Built for FAF ecosystem demos*
*VHS by Charmbracelet - https://github.com/charmbracelet/vhs*
