#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "=== Tech Idea to Docs — Installer ==="
echo ""

# Ensure skills directory exists
mkdir -p "$SKILLS_DIR"

# List of skills to install
SKILLS=("tech-idea-to-docs" "traceability-matrix" "browser-verification" "masterplan-cross-reference-audit")

for skill in "${SKILLS[@]}"; do
	src="$REPO_DIR/skills/$skill/SKILL.md"
	dest="$SKILLS_DIR/$skill/SKILL.md"

	if [ ! -f "$src" ]; then
		echo "[ERROR] Missing source: $src"
		exit 1
	fi

	# Backup existing skill if it differs
	if [ -f "$dest" ]; then
		if ! diff -q "$src" "$dest" > /dev/null 2>&1; then
			backup="$dest.backup.$(date +%Y%m%d%H%M%S)"
			cp "$dest" "$backup"
			echo "[BACKUP] $skill — existing version saved to $backup"
		else
			echo "[SKIP]   $skill — already up to date"
			continue
		fi
	fi

	mkdir -p "$SKILLS_DIR/$skill"
	cp "$src" "$dest"
	echo "[INSTALL] $skill"
done

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Installed skills:"
echo "  /tech-idea-to-docs              — main pipeline (Sessions 0-4)"
echo "  /traceability-matrix            — plan coverage verification"
echo "  /browser-verification           — UI verification (Gate 3)"
echo "  /masterplan-cross-reference-audit — spec compliance (Gate 4)"
echo ""
echo "Usage: Open any Claude Code session and run /tech-idea-to-docs"
echo ""
