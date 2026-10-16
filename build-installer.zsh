#!/bin/zsh
emulate -L zsh
setopt errexit nounset pipefail

cd "${0:A:h}"

[[ -f makebrew && ! -L makebrew ]] || {
  print -u2 'Missing trusted makebrew source'
  exit 1
}

command -v pkgbuild >/dev/null || {
  print -u2 'pkgbuild unavailable'
  exit 1
}

zsh -n makebrew

STAGING="$(mktemp -d "${TMPDIR:-/tmp/}makebrew.XXXXXXXX")"
[[ -d "$STAGING" && ! -L "$STAGING" ]] || exit 1

cleanup() {
  if [[ -n "$STAGING" &&
        "$STAGING" == "${TMPDIR:-/tmp/}"makebrew.* &&
        -d "$STAGING" && ! -L "$STAGING" ]]; then
    command rm -rf -- "$STAGING"
  fi
}
trap cleanup EXIT

mkdir -p "$STAGING/payload/usr/local/bin"
mkdir -p dist

cp makebrew "$STAGING/payload/usr/local/bin/makebrew"
chmod 755 "$STAGING/payload/usr/local/bin/makebrew"

pkgbuild \
  --root "$STAGING/payload" \
  --identifier org.makebrew.runtime \
  --version 1.0.1 \
  --install-location / \
  "$PWD/dist/MAKEBREW.pkg"

print 'Package built: dist/MAKEBREW.pkg'
print 'Review package contents and signing before installation.'
