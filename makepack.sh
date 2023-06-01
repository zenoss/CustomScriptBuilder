#!/bin/bash
##############################################################################
#
# Copyright (C) Zenoss, Inc. 2023, all rights reserved.
#
#
##############################################################################

author=''
name=''
version=''

print_usage() {
  printf "Usage: ./makepack.sh -a <AUTHOR> -n <Company/Packname> -v <VERSION>\n"
}

build_zp_fs_struct() {
   if test -d "$newroot" ; then rm -rf "$newroot" ; fi
   cp -r skel/ZenPacks.example.CustomScripts "$newroot"
   #mv $(find . -mindepth 1 -maxdepth 1 -type d -path . -prune -o -name 'ZenPacks.*')  $newroot
   mv $(find ZenPacks.$name.CustomScripts/ZenPacks/ -mindepth 1 -maxdepth 1 -type d) "ZenPacks.$name.CustomScripts/ZenPacks/$name"
   cp libexec/* "$newroot/ZenPacks/$name/CustomScripts/libexec/"
   chmod +x $newroot/ZenPacks/$name/CustomScripts/libexec/*

   cd "$newroot"
   sed -i 's/AUTHOR\ =.*/AUTHOR\ =\ '"'$author'"'/' setup.py
   sed -i "s/example/$name/" setup.py
   sed -i 's/VERSION\ =.*/VERSION\ =\ "'$version'"/' setup.py

   sed -i "s/example/$name/" "ZenPacks/$name/CustomScripts/zenpack.yaml"

}

noargs="true"
while getopts 'a:n:v:h' flag; do
  case "${flag}" in
    a) author="${OPTARG}" ;;
    n) name="${OPTARG}" ;;
    v) version="${OPTARG}" ;;
    h) print_usage
       exit 1 ;;
    *) print_usage
       exit 1 ;;
  esac
  noargs="false"

done

if [ "$noargs" == "true" ]; then
   print_usage
   exit 1
elif [ -z "$author" ] || [ -z "$name" ] || [ -z "$version" ] ; then
   echo "ERROR: Missing needed argument..." 
   exit 1
fi

newroot='ZenPacks.'$name'.CustomScripts'
buildzpout=$(build_zp_fs_struct 2>&1)
if [ ! -z "$buildzpout" ]; then
   echo "ERROR: Issue building ZP file structure."
   echo "$buildzpout"
   exit 1
fi

cd "$newroot"
buildeggout=$(/usr/bin/env python setup.py build bdist_egg  2>&1)
if [ $? -eq 0 ] ; then
   cp dist/*.egg ../
   cd .. ; ls -1 *.egg
   rm -fR $newroot dist
else
   echo "ERROR: There was an issue building the ZP."
   echo "$buildeggout"
   exit 1
fi
