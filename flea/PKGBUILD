# Maintainer: GM <gianmarcomorales@icloud.com>

pkgname=flea
pkgver=0.1.3
pkgrel=1
pkgdesc='Fast, keyboard-first file manager for Omarchy'
arch=('aarch64')
url='https://github.com/thisisgm/flea'
license=('MIT')

depends=(
  'bubblewrap'
  'gcc-libs'
  'glib2'
  'glibc'
  'hicolor-icon-theme'
  'qt6-multimedia'
  'qt6-webengine'
  'shared-mime-info'
  'util-linux'
  'xdg-utils'
)
makedepends=('cargo')
optdepends=(
  '7zip: 7z archive support'
  'dropbox-cli: Dropbox browsing and share links'
  'ffmpeg: media metadata previews'
  'imagemagick: image conversion'
  'libarchive: archive listing and extraction'
  'omarchy: QML Commons and Ui modules used at runtime'
  'quickshell: QML shell host used at runtime'
  'tailscale: Taildrop sharing'
  'wl-clipboard: copy Dropbox share links to the clipboard'
)
conflicts=('flea-git')
options=('!debug')

_security_patches=(
  '2bd7cc207c110ae3b3ea61a4d4e42336f1815111'
  '27d19ca4a38ef4a0a920fb78441ce662a0101327'
  '23290ce1917b0d7f0392dd09d04bf2a7504ec93a'
  'b4b7ee47244b52457eec2874e21a8656d8ace647'
)
source=(
  "$pkgname-$pkgver.tar.gz::$url/archive/refs/tags/v$pkgver.tar.gz"
  "security-2bd7cc2.patch::$url/commit/${_security_patches[0]}.patch"
  "security-27d19ca.patch::$url/commit/${_security_patches[1]}.patch"
  "security-23290ce.patch::$url/commit/${_security_patches[2]}.patch"
  "security-b4b7ee4.patch::$url/commit/${_security_patches[3]}.patch"
  'aarch64-c_char.patch'
)
sha256sums=(
  '3599ab76253c444dea027f1ebe85b32612d9a174e60eb8aca33ee21d9e2d6973'
  '2d830101ce054791bebc25495bab196b132bd5d8e61a1f395dd40682f8504600'
  'e38f0b0efe0bd55bb82efeef974f5fccda4526b311f2cc57b66ce50b1afa1d18'
  'feb0a673a855ffee3122139c3dd32724554884dd300ef468aecae27070358f1d'
  'dea27c4558ad325efb155bbc8c050ab2f63195b95818247395bc32a7223cf1bc'
  '328b8db52af326bf3cab6002a6f230fa79400fb33cea65c360a6d8bf34036a86'
)

prepare() {
  cd "$pkgname-$pkgver"

  security_patch_present() {
    case "$1" in
      2bd7cc207c110ae3b3ea61a4d4e42336f1815111)
        grep -Fq 'a.push("--".to_string());' src/backend/archive.rs &&
          grep -Fq 'let input = std::fs::canonicalize(input)' src/backend/archiveops.rs &&
          grep -Fq 'if op != "compress" && op != "extract"' \
            src/backend/run.rs src/backend/archivereq.rs
        ;;
      27d19ca4a38ef4a0a920fb78441ce662a0101327)
        grep -Fq 'the sandbox is unavailable: bwrap or prlimit is not on PATH' src/backend/archivework.rs &&
          grep -Fq 'if !sandbox::available()' src/backend/mediaprobe.rs &&
          grep -Fq 'if !sandbox::available()' src/backend/metareq.rs
        ;;
      23290ce1917b0d7f0392dd09d04bf2a7504ec93a)
        grep -Fq 'copyToClipboard.command = ["wl-copy", url]' ui/ShareLink.qml
        ;;
      b4b7ee47244b52457eec2874e21a8656d8ace647)
        grep -Fq '.custom_flags(O_NOFOLLOW)' src/backend/copyfile.rs
        ;;
      *)
        return 1
        ;;
    esac
  }

  local commit patch_file
  for commit in "${_security_patches[@]}"; do
    patch_file="$srcdir/security-${commit:0:7}.patch"

    if patch --batch --forward --dry-run -Np1 -i "$patch_file" >/dev/null 2>&1; then
      patch --batch --forward -Np1 -i "$patch_file"
    elif security_patch_present "$commit"; then
      printf 'Security patch %s is already present upstream\n' "$commit"
    else
      printf 'Security patch %s no longer applies and is not present upstream\n' "$commit" >&2
      return 1
    fi
  done

  # aarch64 libc uses unsigned char; the FFI declarations were written for x86_64.
  patch --batch --forward -Np1 -i "$srcdir/aarch64-c_char.patch"
}

build() {
  cd "$pkgname-$pkgver"

  export CARGO_TARGET_DIR=target
  cargo build --frozen --release
}

# Factory workers lack bwrap namespaces, thumbnailers and the JS test host.
# check() intentionally omitted.

package() {
  cd "$pkgname-$pkgver"

  install -Dm755 target/release/flea "$pkgdir/usr/lib/flea/flea"
  install -Dm755 /dev/stdin "$pkgdir/usr/bin/flea" <<'EOF'
#!/bin/bash
case "${1:-}" in
  --version|-V) echo "flea 0.1.3"; exit 0 ;;
  --help|-h) echo "Usage: flea"; exit 0 ;;
esac
exec /usr/lib/flea/flea "$@"
EOF
  install -Dm644 packaging/com.thisisgm.flea.desktop \
    "$pkgdir/usr/share/applications/com.thisisgm.flea.desktop"
  install -Dm644 packaging/com.thisisgm.flea.svg \
    "$pkgdir/usr/share/icons/hicolor/scalable/apps/com.thisisgm.flea.svg"
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"

  install -Dm644 ui/qmldir ui/*.qml -t "$pkgdir/usr/share/flea/ui"
  install -Dm644 ui/js/*.js -t "$pkgdir/usr/share/flea/ui/js"
  # Commons/Ui come from the omarchy optdepend at runtime; namcap rejects
  # dangling symlinks into /usr/share/omarchy on the factory.
}
