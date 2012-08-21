#!/bin/bash

####################################################################################################
# import the BLDR system
####################################################################################################

source "bldr.sh"

####################################################################################################
# setup pkg definition and resource files
####################################################################################################

pkg_ctry="graphics"
pkg_name="pango-cairo"
pkg_vers="1.30.1"

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

pkg_file="pango-$pkg_vers.tar.xz"
pkg_urls="http://ftp.gnome.org/pub/GNOME/sources/$pkg_name/1.30/$pkg_file"
pkg_opts="configure"
pkg_reqs=""
pkg_reqs="$pkg_reqs zlib/latest"
pkg_reqs="$pkg_reqs libicu/latest"
pkg_reqs="$pkg_reqs libiconv/latest"
pkg_reqs="$pkg_reqs libxml2/latest"
pkg_reqs="$pkg_reqs freetype/latest"
pkg_reqs="$pkg_reqs fontconfig/latest"
pkg_reqs="$pkg_reqs gettext/latest"
pkg_reqs="$pkg_reqs glib/latest"
pkg_reqs="$pkg_reqs gobject-isl/latest"
pkg_reqs="$pkg_reqs cairo/latest"
pkg_uses="$pkg_reqs"
pkg_cfg="--enable-static --enable-shared --enable-introspection=yes"
pkg_cflags=""
pkg_ldflags=""

####################################################################################################
# build and install pkg as local module
####################################################################################################

bldr_build_pkg                 \
  --category    "$pkg_ctry"    \
  --name        "$pkg_name"    \
  --version     "$pkg_vers"    \
  --info        "$pkg_info"    \
  --description "$pkg_desc"    \
  --file        "$pkg_file"    \
  --url         "$pkg_urls"    \
  --uses        "$pkg_uses"    \
  --requires    "$pkg_reqs"    \
  --options     "$pkg_opts"    \
  --cflags      "$pkg_cflags"  \
  --ldflags     "$pkg_ldflags" \
  --config      "$pkg_cfg"

