pkg_name=config
pkg_origin=smith
pkg_version=0.1.0
pkg_maintainer="Nathan L Smith <smith@nlsmith.com>"
pkg_license=('Apache-2.0')
pkg_deps=(core/bash)
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  cp -R bin etc "$pkg_prefix"
}

do_strip() {
  return 0
}
