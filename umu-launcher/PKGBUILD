# Factory: portable Python/Rust source. Arch extra ships x86_64 only.

pkgname=umu-launcher
pkgver=1.4.4
pkgrel=1
pkgdesc='Unified Launcher for Windows Games on Linux, to run Proton with fixes outside of Steam'
arch=('aarch64')
url='https://github.com/Open-Wine-Components/umu-launcher'
license=('GPL-3.0-only')
depends=(
  bash
  curl
  dbus
  diffutils
  glibc
  gcc-libs
  libxcrypt
  lsof
  python
  python-xlib
  python-urllib3
)
makedepends=(
  cargo
  git
  patchelf
  python-build
  python-hatchling
  python-installer
  python-pip
  python-wheel
  scdoc
)
source=("git+https://github.com/Open-Wine-Components/umu-launcher.git#tag=${pkgver}")
sha256sums=('SKIP')

build() {
  cd "${srcdir}/umu-launcher"
  ./configure.sh --prefix=/usr --use-system-urllib
  make
}

package() {
  cd "${srcdir}/umu-launcher"
  make DESTDIR="${pkgdir}" install
}
