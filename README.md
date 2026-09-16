# omarchy-arm-pkgbuilds

ARM PKGBUILDs for Omarchy pool factory. No AI drafting needed — workers run `makepkg` directly.
Each dir is a pacman package (AUR-style, already `arch=('...aarch64...')`).
Used via `POST /factory/packages {url:https://github.com/maralcbr/omarchy-arm-pkgbuilds, pkgbuild_path:<dir>/PKGBUILD}`.

## Unpackageable on aarch64 (no official ARM binary or portable source)

These names exist on Omarchy x86 and will not get a factory recipe until upstream ships ARM artifacts:

- `heroic-games-launcher-bin` — Heroic has no Linux arm64 build
- `microsoft-edge-stable-bin` — Edge Linux debs are amd64-only
- `dropbox` / `dropbox-cli` / `nautilus-dropbox` — `dropbox-lnx.aarch64-*` 404s
- `minecraft-launcher` — official launcher is x86_64
- `wine-staging` / `wine-mono` / `wine-gecko` — Asahi uses FEX; not in aarch64-required optionals
- `tmog-bin` — upstream tarball is x86_64
- `python-mediapipe` — no aarch64 wheel, blocks `link-studio`
- `claude-desktop` / `schist` / `slap-notes` / `cua` / `omareel` — not in the OPR trees we package from
