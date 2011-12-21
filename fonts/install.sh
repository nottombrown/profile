#!/bin/bash

mkdir /usr/share/fonts/truetype/custom
cp *.ttf /usr/share/fonts/truetype/custom/
fc-cache -f -v
