#!/bin/sh
set -e
set -x
dir="$(cd $(dirname $0) && pwd)"
usr=$(pwd)/usr
pkg=$(pwd)/pkg
mkdir -p $pkg
curl -L -O https://cdn.netbsd.org/pub/pkgsrc/stable/pkgsrc.tgz
mkdir -p $usr
gunzip < pkgsrc.tgz| tar -f - -x -C $usr
cd $usr/pkgsrc/bootstrap &&
    ./bootstrap \
        --compiler clang \
        --cwrappers no \
        --mk-fragment $dir/mk.conf \
        --prefix $pkg \
        --unprivileged ||
    (
        cat $usr/pkgsrc/bootstrap/work/bmake/config.log
    )
cat << EOF > $pkg/.pkgsrc_profile
export PATH="$pkg/bin:\$PATH"
export PATH="$pkg/sbin:\$PATH"
export MANPATH="$pkg/man:\$MANPATH"
export PERL5LIB="$pkg/lib/perl5:\$PERL5LIB"
export PKG_CONFIG_PATH="$pkg/lib/pkgconfig:\$PKG_CONFIG_PATH"
EOF
