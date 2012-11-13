#!/bin/bash

####################################################################################################
# import the BLDR system
####################################################################################################

source "bldr.sh"

####################################################################################################
# setup pkg definition and resource files
####################################################################################################

pkg_ctry="services"
pkg_name="cocaine-plugins"

pkg_default="trunk"
pkg_variants=("trunk")

pkg_info="Cocaine is an open-source cloud platform enabling you to build your own PaaS clouds using simple yet effective dynamic components."

pkg_desc="Cocaine is an open-source cloud platform enabling you to build your own PaaS clouds using simple yet effective dynamic components."

pkg_opts="cmake "

pkg_reqs="zlib "
pkg_reqs+="libev "
pkg_reqs+="zeromq "
pkg_reqs+="msgpack "
pkg_reqs+="boost "
pkg_reqs+="python "
pkg_reqs+="perl "
pkg_reqs+="cocaine-core "
pkg_uses="$pkg_reqs "

####################################################################################################
# satisfy pkg dependencies and load their environment settings
####################################################################################################

bldr_satisfy_pkg                 \
    --category    "$pkg_ctry"    \
    --name        "$pkg_name"    \
    --version     "$pkg_default" \
    --requires    "$pkg_reqs"    \
    --uses        "$pkg_uses"    \
    --options     "$pkg_opts"

####################################################################################################

boost_list="$BLDR_BOOST_LIB_PATH/libboost_system.a "
boost_list+="$BLDR_BOOST_LIB_PATH/libboost_regex.a "
boost_list+="$BLDR_BOOST_LIB_PATH/libboost_thread.a "
boost_list+="$BLDR_BOOST_LIB_PATH/libboost_filesystem.a "
boost_list+="$BLDR_BOOST_LIB_PATH/libboost_program_options.a"

pkg_ldflags="-L$BLDR_LIBEV_LIB_PATH " 
pkg_ldflags+="-L$BLDR_MSGPACK_LIB_PATH " 
pkg_ldflags+="-L$BLDR_COCAINE_CORE_LIB_PATH " 
pkg_ldflags+="-L$BLDR_BOOST_LIB_PATH $boost_list " 

pkg_cfg="-DMONGO=OFF "
pkg_cfg+="-DJAVASCRIPT=OFF "
pkg_cfg+="-DCMAKE_C_FLAGS='-I$BLDR_BOOST_INCLUDE_PATH -I$BLDR_LIBTOOL_LIB_PATH' "
pkg_cfg+="-DCMAKE_CXX_FLAGS='$pkg_ldflags' "
pkg_cfg+="-DBoost_NO_SYSTEM_PATHS=ON "
pkg_cfg+="-DBoost_NO_BOOST_CMAKE=ON "
pkg_cfg+="-DBoost_DIR=\"$BLDR_BOOST_BASE_PATH\" "
pkg_cfg+="-DBoost_INCLUDE_DIR=\"$BLDR_BOOST_INCLUDE_PATH\" "
pkg_cfg+="-DBOOST_ROOT=\"$BLDR_BOOST_BASE_PATH\" "
pkg_cfg+="-DBoost_DEBUG=OFF "
pkg_cfg+="-DBoost_FOUND=TRUE "
pkg_cfg+="-DBoost_INCLUDE_DIR=\"$BLDR_BOOST_INCLUDE_PATH\" "
pkg_cfg+="-DBoost_LIBRARY_DIRS=\"$BLDR_BOOST_LIB_PATH\" "

if [[ $BLDR_SYSTEM_IS_LINUX == true ]]
then
     pkg_cflags+="-fPIC "
fi


####################################################################################################
# register each pkg version with bldr
####################################################################################################

for pkg_vers in ${pkg_variants[@]}
do
    pkg_file="$pkg_name-$pkg_vers-$BLDR_TIMESTAMP.tar.gz"
    pkg_urls="git://github.com/cocaine/cocaine-plugins.git"

    bldr_register_pkg                 \
         --category    "$pkg_ctry"    \
         --name        "$pkg_name"    \
         --version     "$pkg_vers"    \
         --default     "$pkg_default" \
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
