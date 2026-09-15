# omarchy-arm-pkgbuilds
ARM PKGBUILDs for Omarchy pool factory. No AI drafting needed — workers run `makepkg` directly.
Each dir is a pacman package (AUR-style, already `arch=('...aarch64...')`).
Used via `POST /factory/packages {url:https://github.com/maralcbr/omarchy-arm-pkgbuilds, pkgbuild_path:<dir>/PKGBUILD}`.
