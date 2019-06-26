#!/bin/sh

CHANGES=$(git status --porcelain)
if [ -n "$CHANGES" ];
    then echo changed
else
  echo unchanged
fi
