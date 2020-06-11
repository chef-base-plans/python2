# shellcheck disable=SC2148,SC1091
source ../python/plan.sh

# TODO: Should this be renamed to python27 in accordance with RFC 0003?
# If so, the python2 namespace would need to be deprecated per RFC 0007
pkg_name=python2
pkg_distname=Python
pkg_version=2.7.18
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Python-2.0')
pkg_description="Python is a programming language that lets you work quickly \
  and integrate systems more effectively."
pkg_upstream_url="https://www.python.org"
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_source="https://www.python.org/ftp/python/${pkg_version}/${pkg_dirname}.tgz"
pkg_shasum="da3080e3b488f648a3d7a4560ddee895284c3380b11d6de75edb986526b9a814"
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/gcc
  core/linux-headers
  core/make
  core/util-linux
)

pkg_deps=(
  core/bzip2
  core/expat
  core/gcc-libs
  core/gdbm
  core/glibc
  core/libffi
  core/ncurses
  core/openssl
  core/readline
  core/sqlite
  core/zlib
)

pkg_interpreters=(bin/python bin/python2 bin/python2.7)

do_build() {
    # TODO: We should build with `--enable-optimizations`
    ./configure --prefix="$pkg_prefix" \
                --enable-shared \
                --enable-unicode=ucs4 \
                --with-threads \
                --with-system-expat \
                --with-system-ffi \
                --with-ensurepip

    make
}

do_install() {
  do_default_install

  # Remove idle as we are not building with Tk/x11 support so it is useless
  rm -vf "$pkg_prefix/bin/idle"
}
