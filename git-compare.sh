#!/bin/bash

if [[ $# -eq 1 ]] ; then
    git log --oneline $1..$(git branch --show-current)
elif [[ $# -eq 2 ]] ; then
    git log --oneline $1..$2
else
    git log --oneline main..$(git branch --show-current)
fi

