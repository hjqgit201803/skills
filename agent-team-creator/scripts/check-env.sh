#!/bin/bash
# Check if Agent Teams environment is properly configured

echo "=== Claude Code Agent Teams Environment Check ==="
echo ""

# Check 1: Environment variable
echo "1. Checking CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS..."
if [ "$CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS" = "1" ]; then
    echo "   ✓ Agent Teams is enabled"
else
    echo "   ✗ Agent Teams is NOT enabled"
    echo "   Set it with: export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1"
    echo "   Or add to settings.json:"
    echo '   {"env": {"CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"}}'
fi
echo ""

# Check 2: Settings.json configuration
echo "2. Checking settings.json..."
SETTINGS_FILE="$HOME/.claude/settings.json"
if [ -f "$SETTINGS_FILE" ]; then
    if grep -q "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS" "$SETTINGS_FILE" 2>/dev/null; then
        echo "   ✓ Found in settings.json"
    else
        echo "   ℹ Not configured in settings.json (environment variable is sufficient)"
    fi
else
    echo "   ℹ settings.json not found (will use defaults)"
fi
echo ""

# Check 3: Teammate mode
echo "3. Checking teammate mode configuration..."
if grep -q "teammateMode" "$SETTINGS_FILE" 2>/dev/null; then
    MODE=$(grep -o '"teammateMode"[[:space:]]*:[[:space:]]*"[^"]*"' "$SETTINGS_FILE" | cut -d'"' -f4)
    echo "   ✓ Teammate mode: $MODE"
else
    echo "   ℹ Using default mode (auto)"
fi
echo ""

# Check 4: tmux (for split-pane mode)
echo "4. Checking for tmux (required for split-pane mode)..."
if command -v tmux &> /dev/null; then
    TMUX_VERSION=$(tmux -V | cut -d' ' -f2)
    echo "   ✓ tmux installed: version $TMUX_VERSION"
else
    echo "   ℹ tmux not found (only in-process mode available)"
    echo "   Install with: apt install tmux  # Debian/Ubuntu"
    echo "              brew install tmux    # macOS"
fi
echo ""

# Check 5: Existing teams
echo "5. Checking existing teams..."
TEAMS_DIR="$HOME/.claude/teams"
if [ -d "$TEAMS_DIR" ]; then
    TEAM_COUNT=$(ls -1 "$TEAMS_DIR" 2>/dev/null | wc -l)
    echo "   ✓ Found $TEAM_COUNT existing team(s):"
    ls -1 "$TEAMS_DIR" 2>/dev/null | sed 's/^/     - /'
else
    echo "   ℹ No teams directory yet"
fi
echo ""

echo "=== Check Complete ==="
