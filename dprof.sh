#!/bin/bash

case $1 in
    reset )
        xcalib -c && sct
    ;;
    dayvid )
        xcalib -c 
        xcalib -gc .7 -a
    ;;
    night1 )
        xcalib -c
        xcalib -gc .8 -a && sct 4500
    ;;
    night2 )
        xcalib -c
        xcalib -gc .8 -co 80 && sct 2500
    ;;
    * )
        echo -e "\"$1\" is not currently defined"
    ;;
esac
