#! /bin/bash

fileName=""
downDir="/root/Download"

file="$downDir/$fileName"

transfers=4

name=gd
folder=Download

rclone copy --transfers=$transfers "$name:$folder/$fileName" "${file}"
