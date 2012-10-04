#!/bin/bash

####################################################################################################
# import the BLDR system
####################################################################################################

source "bldr.sh"

####################################################################################################
# setup pkg definition and resource files
####################################################################################################

pkg_ctry="typography"
pkg_name="pango"

pkg_info="Pango is a library for laying out and rendering of text, with an emphasis on internationalization."

pkg_desc="Pango is a library for laying out and rendering of text, with an emphasis on 
internationalization. Pango can be used anywhere that text layout is needed, though most 
of the work on Pango so far has been done in the context of the GTK+ widget toolkit. 
Pango forms the core of text and font handling for GTK+-2.x.

Pango is designed to be modular; the core Pango layout engine can be used with different 
font backends. There are three basic backends, with multiple options for rendering with each.

Client side fonts using the FreeType and fontconfig libraries. Rendering can be with with 
Cairo or Xft libraries, or directly to an in-memory buffer with no additional libraries.

Native fonts on Microsoft Windows using Uniscribe for complex-text handling. Rendering 
can be done via Cairo or directly using the native Win32 API.

Native fonts on MacOS X using ATSUI for complex-text handling, rendering via Cairo.

The integration of Pango with Cairo (http://cairographics.org/) provides a complete solution
 with high quality text handling and graphics rendering.

Dynamically loaded modules then handle text layout for particular combinations of script and 
font backend. Pango ships with a wide selection of modules, including modules for 
Hebrew, Arabic, Hangul, Thai, and a number of Indic scripts. Virtually all of the world's 
major scripts are supported.

As well as the low level layout rendering routines, Pango includes PangoLayout, a high 
level driver for laying out entire blocks of text, and routines to assist in editing 
internationalized text.

Pango depends on 2.x series of the GLib library; more information about GLib can be 
found at http://www.gtk.org/."

pkg_vers_dft="1.30.1"
pkg_vers_list=("$pkg_vers_dft")

pkg_opts="configure"
pkg_reqs="pkg-config"
pkg_reqs="$pkg_reqs zlib"
pkg_reqs="$pkg_reqs libicu"
pkg_reqs="$pkg_reqs libiconv"
pkg_reqs="$pkg_reqs libxml2"
pkg_reqs="$pkg_reqs freetype"
pkg_reqs="$pkg_reqs fontconfig"
pkg_reqs="$pkg_reqs gettext"
pkg_reqs="$pkg_reqs glib"
pkg_uses="$pkg_reqs"

####################################################################################################
# satisfy pkg dependencies and load their environment settings
####################################################################################################

bldr_satisfy_pkg                  \
  --category    "$pkg_ctry"       \
  --name        "$pkg_name"       \
  --version     "$pkg_vers_dft"   \
  --requires    "$pkg_reqs"       \
  --uses        "$pkg_uses"       \
  --options     "$pkg_opts"

####################################################################################################

pkg_cfg="--enable-static --enable-shared --disable-introspection"
pkg_cflags=""
pkg_cflags="$pkg_cflags:-I$BLDR_GLIB_INCLUDE_PATH/glib-2.0"
pkg_cflags="$pkg_cflags:-I$BLDR_GLIB_INCLUDE_PATH/gio-unix-2.0"
pkg_ldflags=""

####################################################################################################
# register each pkg version with bldr
####################################################################################################

for pkg_vers in ${pkg_vers_list[@]}
do
    pkg_file="$pkg_name-$pkg_vers.tar.xz"
    pkg_urls="http://ftp.gnome.org/pub/GNOME/sources/$pkg_name/1.30/$pkg_file"

    bldr_register_pkg                 \
         --category    "$pkg_ctry"    \
         --name        "$pkg_name"    \
         --version     "$pkg_vers"    \
         --default     "$pkg_vers_dft"\
         --info        "$pkg_info"    \
         --description "$pkg_desc"    \
         --file        "$pkg_file"    \
         --url         "$pkg_urls"    \
         --uses        "$pkg_uses"    \
         --requires    "$pkg_reqs"    \
         --options     "$pkg_opts"    \
         --cflags      "$pkg_cflags"  \
         --ldflags     "$pkg_ldflags" \
         --config      "$pkg_cfg"     \
         --config-path "$pkg_cfg_path"
done

####################################################################################################

