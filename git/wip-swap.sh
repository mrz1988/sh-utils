#!/bin/sh

RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

CHANGES=$(git status --porcelain)
if [ -n "$CHANGES" ];
then
  echo "${YELLOW}Branch dirty, making temp commit...${NC}"
  git add -A
  git commit -m "@@WIP"
fi

echo "${GREEN}Checking out branch ${1}...${NC}"
git checkout $1
if git log --pretty=oneline --max-count 1 | grep --quiet @@WIP; then
  echo "${YELLOW}Found dirty WIP changes, uncommitting...${NC}"
  git reset HEAD~
else
  echo "${GREEN}Commit history clean, no WIP.${NC}"
fi

echo "${GREEN}All set!${NC}"
