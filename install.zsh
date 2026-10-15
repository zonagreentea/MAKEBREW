#!/bin/zsh
emulate -L zsh
setopt errexit nounset pipefail

REPO="https://github.com/zonagreentea/MAKEBREW.git"
DEST="${MAKEBREW_HOME:-$HOME/.local/share/makebrew}"
BIN="$HOME/.local/bin"
TMP=""

cleanup() {
  [[ -z "$TMP" ]] || rm -rf -- "$TMP"
}
trap cleanup EXIT

for tool in git zsh mktemp mkdir chmod ln; do
  command -v "$tool" >/dev/null 2>&1 || {
    print -u2 "MAKEBREW: missing $tool"
    exit 1
  }
done

if [[ -e "$DEST" && ! -d "$DEST/.git" ]]; then
  print -u2 "MAKEBREW: destination already exists"
  exit 1
fi

if [[ -d "$DEST/.git" ]]; then
  [[ -z "$(git -C "$DEST" status --porcelain)" ]] || {
    print -u2 "MAKEBREW: local changes detected"
    exit 1
  }
  git -C "$DEST" pull --ff-only
else
  mkdir -p -- "${DEST:h}"
  TMP="$(mktemp -d)"
  git clone -- "$REPO" "$TMP/source"
  mv -- "$TMP/source" "$DEST"
fi

[[ -f "$DEST/makebrew" ]] || {
  print -u2 "MAKEBREW: launcher missing"
  exit 1
}

chmod +x "$DEST/makebrew"
mkdir -p "$BIN"

if [[ -e "$BIN/makebrew" && ! -L "$BIN/makebrew" ]]; then
  print -u2 "MAKEBREW: command name already occupied"
  exit 1
fi

ln -sfn "$DEST/makebrew" "$BIN/makebrew"

print "MAKEBREW installed: $DEST"
print "Launcher: $BIN/makebrew"

if [[ ":$PATH:" != *":$BIN:"* ]]; then
  print "Add $BIN to your PATH."
fi

if [[ ! -x "$HOME/work/KNU/KNU" ]]; then
  print "Warning: current runtime requires KNU."
fi
