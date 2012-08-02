#!/bin/bash

####################################################################################################
# import the BLDR system
####################################################################################################

source "bldr.sh"

####################################################################################################
# setup pkg definition and resource files
####################################################################################################

pkg_ctry="developer"
pkg_name="ncurses"
pkg_vers="5.9"
pkg_info="The Ncurses (new curses) library is a free software emulation of curses in System V Release 4.0, and more."

pkg_desc="The Ncurses (new curses) library is a free software emulation of curses in System V Release 4.0, 
and more. It uses Terminfo format, supports pads and color and multiple highlights and forms characters 
and function-key mapping, and has all the other SYSV-curses enhancements over BSD Curses.

The ncurses code was developed under GNU/Linux. It has been in use for some time with OpenBSD as 
the system curses library, and on FreeBSD and NetBSD as an external package. It should port 
easily to any ANSI/POSIX-conforming UNIX. It has even been ported to OS/2 Warp!

The distribution includes the library and support utilities, including a terminfo compiler 
tic, a decompiler infocmp, clear, tput, tset, and a termcap conversion tool captoinfo. Full 
manual pages are provided for the library and tools."

pkg_file="$pkg_name-$pkg_vers.tar.gz"
pkg_urls="http://ftp.gnu.org/pub/gnu/$pkg_name/$pkg_file"
pkg_opts="configure"
pkg_reqs="pkg-config/latest zlib/latest"
pkg_uses="tar/latest tcl/latest m4/latest autoconf/latest automake/latest $pkg_reqs"

pkg_cflags="-I$BLDR_LOCAL_PATH/internal/zlib/latest/include"
pkg_ldflags="-L$BLDR_LOCAL_PATH/internal/zlib/latest/lib:-lz"

pkg_cfg=""
pkg_patch=""

####################################################################################################
####################################################################################################
# build and install pkg as local module
####################################################################################################

bldr_build_pkg --category    "$pkg_ctry"    \
               --name        "$pkg_name"    \
               --version     "$pkg_vers"    \
               --info        "$pkg_info"    \
               --description "$pkg_desc"    \
               --file        "$pkg_file"    \
               --url         "$pkg_urls"    \
               --uses        "$pkg_uses"    \
               --requires    "$pkg_reqs"    \
               --options     "$pkg_opts"    \
               --patch       "$pkg_patch"   \
               --cflags      "$pkg_cflags"  \
               --ldflags     "$pkg_ldflags" \
               --config      "$pkg_cfg"

