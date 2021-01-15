#! /bin/sh
# 0 0 * * 1 
rm -rf /tmp/*
workdir="/"
cd "$workdir"
#for i in `find . -name "*.log"`; do cat /dev/null > $i; done
for i in `find . -name "*.log"`; do rm -f $i; done
