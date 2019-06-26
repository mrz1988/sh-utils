#!/bin/sh

git add -A
git commit -m "@@WIP"
git checkout $1
if git log --pretty=oneline --max-count 1 | grep --quiet @@WIP; then
  echo Found dirty WIP changes, uncommitting...
  git reset HEAD~
else
  echo Commit history clean, no WIP.
fi
