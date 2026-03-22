# FAF Demo Template
# Replace {FEATURE} and commands as needed

Output "{FEATURE}-demo.gif"

Set FontSize 18
Set Width 800
Set Height 400
Set Theme "Dracula"
Set Padding 20
Set TypingSpeed 40ms

# Ensure colors work
Set Env "FORCE_COLOR" "1"

# Title
Type "# FAF {FEATURE} Demo"
Enter
Sleep 1s

# Navigate to project
Type "cd /path/to/project"
Enter
Sleep 300ms

# Main command
Type "faf {command}"
Enter
Sleep 3s

# Explanation
Type ""
Enter
Type "# Key insight here"
Enter
Sleep 2s
