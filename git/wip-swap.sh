#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

git merge HEAD &> /dev/null
MERGE_RESULT=$?

if [ $MERGE_RESULT -ne 0 ]
then
  echo "> ${RED}Merge in progress. Finish before changing branches.${NC}"
  exit 1
fi

REBASE_MERGE_DIR="$(git rev-parse --git-path rebase-merge)"
REBASE_APPLY_DIR="$(git rev-parse --git-path rebase-apply)"

if [ \( -d "$REBASE_RESULT_DIR" \) -o \( -d "$REBASE_APPLY_DIR" \) ]
then
  echo $REBASE_RESULT_DIR
  echo "> ${RED}Rebase in progress. Finish before changing branches.${NC}"
  exit 1
fi


CHANGES=$(git status --porcelain) &> /dev/null
if [ -n "$CHANGES" ];
then
  echo "> ${YELLOW}Branch dirty, making temp commit...${NC}"
  git add -A > /dev/null
  git commit -m "@@WIP" > /dev/null
else
  echo "> ${GREEN}Workspace clean!${NC}"
fi

echo "> ${GREEN}Checking out branch ${1}...${NC}"
git checkout $1 > /dev/null
if git log --pretty=oneline --max-count 1 | grep --quiet @@WIP;
then
  echo "> ${YELLOW}Found dirty WIP changes, uncommitting...${NC}"
  git reset HEAD~ > /dev/null
else
  echo "> ${GREEN}Commit history clean, no WIP.${NC}"
fi

echo "> ${GREEN}All set!${NC}"
