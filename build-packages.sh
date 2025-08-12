#!/bin/sh
set -e
set -x
usr=$(pwd)/usr
pkg=$(pwd)/pkg
. $pkg/.pkgsrc_profile
(
    cd $usr/pkgsrc/archivers/xz
    bmake configure || cat work/xz-*/config.log
    bmake build install clean clean-depends
)
(
    cd $usr/pkgsrc/devel/gettext
    bmake build install clean clean-depends
)
(
    cd $usr/pkgsrc/devel/cmake
    bmake build install clean clean-depends
)
