#!/bin/bash

####################################################################################################
# import the BLDR system
####################################################################################################

source "bldr.sh"

####################################################################################################
# setup pkg definition and resource files
####################################################################################################

pkg_ctry="typography"
pkg_name="texlive"
pkg_vers="2012"

pkg_info="TeX Live provides a live, up-to-date, TeX document production system."

pkg_desc="TeX Live provides a live, up-to-date, TeX document production system.  
It provides a comprehensive TeX system with binaries for most flavors of Unix, including 
GNU/Linux, and also Windows. It includes all the major TeX-related programs, macro 
packages, and fonts that are free software, including support for many languages 
around the world. "

pkg_file="install-tl-unx.tar.gz"
pkg_urls="http://mirror.ctan.org/systems/texlive/tlnet/$pkg_file"
pkg_opts="configure keep skip-install"
pkg_uses="m4/latest autoconf/latest automake/latest"
pkg_reqs=""
pkg_cfg=""
pkg_cflags=""
pkg_ldflags=""

####################################################################################################

function bldr_pkg_compile_method()
{
    local use_verbose="false"
    local pkg_ctry=""
    local pkg_name="" 
    local pkg_vers=""
    local pkg_info=""
    local pkg_desc=""
    local pkg_file=""
    local pkg_urls=""
    local pkg_uses=""
    local pkg_reqs=""
    local pkg_opts=""
    local pkg_cflags=""
    local pkg_ldflags=""
    local pkg_cfg=""
    local pkg_cfg_path=""

    while true ; do
        case "$1" in
           --verbose)       use_verbose="$2"; shift 2;;
           --name)          pkg_name="$2"; shift 2;;
           --version)       pkg_vers="$2"; shift 2;;
           --info)          pkg_info="$2"; shift 2;;
           --description)   pkg_desc="$2"; shift 2;;
           --category)      pkg_ctry="$2"; shift 2;;
           --options)       pkg_opts="$2"; shift 2;;
           --file)          pkg_file="$2"; shift 2;;
           --config)        pkg_cfg="$pkg_cfg:$2"; shift 2;;
           --config-path)   pkg_cfg_path="$2"; shift 2;;
           --cflags)        pkg_cflags="$pkg_cflags:$2"; shift 2;;
           --ldflags)       pkg_ldflags="$pkg_ldflags:$2"; shift 2;;
           --patch)         pkg_patches="$pkg_patches:$2"; shift 2;;
           --uses)          pkg_uses="$pkg_uses:$2"; shift 2;;
           --requires)      pkg_reqs="$pkg_reqs:$2"; shift 2;;
           --url)           pkg_urls="$pkg_urls;$2"; shift 2;;
           * )              break ;;
        esac
    done

    if [ "$use_verbose" == "true" ]
    then
        BLDR_VERBOSE=true
    fi

    local prefix="$BLDR_LOCAL_PATH/$pkg_ctry/$pkg_name/$pkg_vers"
    local base="$BLDR_LOCAL_PATH/$pkg_ctry/$pkg_name"

    bldr_log_status "Building package '$pkg_name/$pkg_vers'"
    bldr_log_split
    
    bldr_log_info "Moving to build path: '$BLDR_BUILD_PATH/$pkg_ctry/$pkg_name/$pkg_vers' ..."
    bldr_log_split
    bldr_push_dir "$BLDR_BUILD_PATH/$pkg_ctry/$pkg_name/$pkg_vers"

    export TEXLIVE_INSTALL_PREFIX="$base"

    local profile="texlive-bldr.profile"
    echo "# TexLive Profile Generated by BLDR $BLDR_VERSION_STR"  >  $profile
    echo "#"                                                      >> $profile
    echo "selected_scheme scheme-small"                           >> $profile
    echo "TEXDIR $base/$pkg_vers"                                 >> $profile
    if [ $BLDR_SYSTEM_IS_OSX -eq 1 ]
    then
      echo "binary_universal-darwin 1"                            >> $profile
    fi

    local output=$(bldr_get_stdout)
    local options="-scheme=small -profile $profile -portable --persistent-downloads "

    if [ -f "./install-tl" ]
    then
        bldr_log_cmd "install-tl $options"
        bldr_log_split

        if [ $BLDR_VERBOSE != false ]
        then
            eval ./install-tl $options || bldr_bail "Failed to install package: '$prefix'"
            bldr_log_split
        else
            eval ./install-tl $options &> /dev/null || bldr_bail "Failed to install package: '$prefix'"
            bldr_log_split
        fi
    fi
    bldr_pop_dir
}


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
               --cflags      "$pkg_cflags"  \
               --ldflags     "$pkg_ldflags" \
               --config      "$pkg_cfg"


