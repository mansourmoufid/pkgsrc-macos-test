#!/bin/sh
set -e
set -x
usr=$(pwd)/usr
pkg=$(pwd)/pkg
source $pkg/.pkgsrc_profile
(
    cd $usr/pkgsrc/devel/gettext
    bmake build install clean clean-depends
)
(
    cd $usr/pkgsrc/devel/cmake
    bmake build install clean clean-depends
)
