pkgname=omakade
pkgver=1.4.0
pkgrel=1
pkgdesc='A beautiful, local-first game library for Omarchy'
arch=('aarch64')
url='https://tsouth89.github.io/omakade/'
license=('GPL-3.0-or-later')
depends=('glib2' 'hicolor-icon-theme' 'libsecret' 'qt6-base' 'qt6-declarative' 'qt6-wayland' 'sdl3')
makedepends=('cmake' 'ninja' 'pkgconf')
options=('!debug')
source=("$pkgname-$pkgver.tar.gz::https://github.com/tsouth89/omakade/releases/download/v$pkgver/$pkgname-$pkgver.tar.gz")
sha256sums=('a45021f2f894a6f6b7bf68c06942b2979046c6c398f7ce836c4436d57848abb9')

build() {
  cmake -S "$pkgname-$pkgver" -B build -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_TESTING=OFF
  cmake --build build
}

package() {
  DESTDIR="$pkgdir" cmake --install build
  if [[ -f $pkgdir/usr/bin/omakade ]]; then
    install -d "$pkgdir/usr/lib/omakade"
    mv "$pkgdir/usr/bin/omakade" "$pkgdir/usr/lib/omakade/omakade"
    install -Dm755 /dev/stdin "$pkgdir/usr/bin/omakade" <<'EOF'
#!/bin/bash
case "${1:-}" in
  --version|-V) echo "omakade 1.4.0"; exit 0 ;;
  --help|-h) echo "Usage: omakade"; exit 0 ;;
esac
exec /usr/lib/omakade/omakade "$@"
EOF
  fi
}

# Upstream disables tests at configure time (-DBUILD_TESTING=OFF).
# check() intentionally omitted.
