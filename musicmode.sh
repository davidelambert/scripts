#!/bin/bash

# Script to launch audio servers for music making
# -----------------------------------------------
# Adapted from http://tedfelix.com/linux/linux-midi.html
#   Archive: https://web.archive.org/web/20210805191244/http://tedfelix.com/linux/linux-midi.html
# Prerequisites:
# - jackd2 (tested w/ 1.9.12)
# - fluidsyth (tested w/ 2.1.1)
# - user membership in `audio` group
#   (add user: `sudo gpasswd -a [user] audio`; log out & in)
# - lowlatency kernel *may* be needed on some systems


case $1 in

    on )
        echo Starting JACK...
        # Start JACK
        # NOTE: period 128 seems to be max for fluisynth not sucking
        pasuspender -- \
            jackd -d alsa --device hw:0 --rate 44100 --period 256 \
                &>/tmp/jackd.out &

        sleep .5

        echo Starting fluidsynth...
        # Start fluidsynth with GM soundfont
        fluidsynth --server --no-shell -p "fluidsynth 1" --audio-driver=jack \
            --connect-jack-outputs --reverb=0 --chorus=0 --gain=0.8 \
            -o midi.autoconnect=false \
            /usr/share/sounds/sf2/FluidR3_GM.sf2 \
            &>/tmp/fluidsynth.out &

        sleep .5

        if pgrep -l jackd && pgrep -l fluidsynth
        then
            echo Audio servers running.
        else
            echo There was a problem starting audio servers.
        fi

        ;;

    off )
        echo Stopping fluidsynth...
        killall fluidsynth
        [ $? == 0 ] || echo There was a problem stopping fluidsynth.

        sleep .5

        echo Stopping JACK...
        killall jackd
        [ $? == 0 ] || echo There was a problem stopping JACK.

        sleep .5

        pgrep -x fluidsyth,jackd && echo "There was a problem stopping audio servers." || echo "Audio servers stopped."

        ;;

    status )
        pgrep -x jackd && echo "JACK is running." || echo "JACK is stopped."
        sleep .5
        pgrep -x fluidsynth && echo "fluidsynth is running." || echo "fluidsynth is stopped."
        sleep .5
        ;;

    * )
        echo Please specify on, off, or status...
        ;;
esac
