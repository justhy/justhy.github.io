#! /bin/sh
rm -rf /tmp/*
workdir="/"
cd $workdir
for i in `find . -name "*.log"`; do cat /dev/null >$i; done
