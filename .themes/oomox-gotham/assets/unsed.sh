#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#0a0f14/g' \
         -e 's/rgb(100%,100%,100%)/#599cab/g' \
    -e 's/rgb(50%,0%,0%)/#0a0f14/g' \
     -e 's/rgb(0%,50%,0%)/#235260/g' \
 -e 's/rgb(0%,50.196078%,0%)/#235260/g' \
     -e 's/rgb(50%,0%,50%)/#132533/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#132533/g' \
     -e 's/rgb(0%,0%,50%)/#599cab/g' \
	$@
