#!/bin/bash

author=''
name=''
version=''

print_usage() {
  printf "Usage: ./makepack.sh -a <AUTHOR> -n <Company/Packname> -v <VERSION>\n"
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
   echo "Missing needed argument..." 
   exit 1
fi


newroot='ZenPacks.'$name'.CustomScripts'
if test -d $newroot ; then rm -rf $newroot ; fi
cp -r skel/ZenPacks.example.CustomScripts $newroot
#mv $(find . -mindepth 1 -maxdepth 1 -type d -path . -prune -o -name 'ZenPacks.*')  $newroot
mv $(find ZenPacks.$name.CustomScripts/ZenPacks/ -mindepth 1 -maxdepth 1 -type d) ZenPacks.$name.CustomScripts/ZenPacks/$name
cp libexec/* $newroot/ZenPacks/$name/CustomScripts/libexec/
chmod +x $newroot/ZenPacks/$name/CustomScripts/libexec/*

#exit 

cd $newroot
sed -i 's/AUTHOR\ =.*/AUTHOR\ =\ '"'$author'"'/' setup.py
sed -i "s/example/$name/" setup.py
sed -i 's/VERSION\ =.*/VERSION\ =\ "'$version'"/' setup.py

buildout=$(/usr/bin/env python setup.py build bdist_egg  2>&1)
if [ $? -eq 0 ] ; then
   cp dist/*.egg ../
   cd .. ; ls -1 *.egg
   rm -fR $newroot dist
else
   echo "There was an issue building the ZP."
   echo "$buildout"
   exit 1
fi

