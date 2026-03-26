#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills"

echo ""
echo "=== Tech Idea to Docs — Uninstaller ==="
echo ""

SKILLS=("tech-idea-to-docs" "traceability-matrix" "browser-verification" "masterplan-cross-reference-audit")

for skill in "${SKILLS[@]}"; do
	dest="$SKILLS_DIR/$skill"
	if [ -d "$dest" ]; then
		rm -rf "$dest"
		echo "[REMOVED] $skill"
	else
		echo "[SKIP]    $skill — not installed"
	fi
done

echo ""
echo "=== Uninstall Complete ==="
echo ""
