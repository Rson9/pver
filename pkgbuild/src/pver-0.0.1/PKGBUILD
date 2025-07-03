pkgname=pver
pkgver=0.1.0
pkgrel=1
arch=('x86_64')
license=('MIT')
depends=()
source=('pver' 'install.sh' 'uninstall.sh')
sha256sums=('SKIP' 'SKIP' 'SKIP')

package() {
  install -Dm755 pver "$pkgdir/usr/bin/pver"
  install -Dm755 install.sh "$pkgdir/usr/share/pver/install.sh"
  install -Dm755 uninstall.sh "$pkgdir/usr/share/pver/uninstall.sh"
}

post_install() {
  bash /usr/share/pver/install.sh
}

post_remove() {
  bash /usr/share/pver/uninstall.sh
}
