#!/bin/bash

#
# ANSI colors
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check if an active merge is open, if so abort
git merge HEAD &> /dev/null
MERGE_RESULT=$?

if [ $MERGE_RESULT -ne 0 ]
then
  echo "> ${RED}Merge in progress. Finish before changing branches.${NC}"
  exit 1
fi


# Check if an active rebase is open, if so abort
REBASE_MERGE_DIR="$(git rev-parse --git-path rebase-merge)"
REBASE_APPLY_DIR="$(git rev-parse --git-path rebase-apply)"

if [ -d "$REBASE_MERGE_DIR" ] || [ -d "$REBASE_APPLY_DIR" ]
then
  echo $REBASE_RESULT_DIR
  echo "> ${RED}Rebase in progress. Finish before changing branches.${NC}"
  exit 1
fi


STAGED_FILES="$(git status --porcelain | grep "^[MADRC]")"
if [ -n "$STAGED_FILES" ]
then
  echo "> ${YELLOW}Branch has staged changes, making temp commit...${NC}"
  git commit -m "@@WIP-STAGED" > /dev/null
else
  echo "> No staged changes :)"
fi

CHANGES=$(git status --porcelain) &> /dev/null
if [ -n "$CHANGES" ];
then
  echo "> ${YELLOW}Branch dirty, making temp commit...${NC}"
  git add -A > /dev/null
  git commit -m "@@WIP-WORKSPACE" > /dev/null
else
  echo "> ${GREEN}Workspace clean!${NC}"
fi

echo "> Checking out branch ${1}..."
git checkout $1 > /dev/null
if git log --pretty=oneline --max-count 1 | grep --quiet @@WIP-WORKSPACE;
then
  echo "> ${YELLOW}Found dirty WIP changes, uncommitting...${NC}"
  git reset HEAD~ > /dev/null
else
  echo "> No WIP Workspace changes."
fi

if git log --pretty=oneline --max-count 1 | grep --quiet @@WIP-STAGED;
then
  echo "> ${YELLOW}Found formerly staged changes.${NC}"
  WORKSPACE=$(git status --porcelain)
  if [ -n "$WORKSPACE" ]
  then
    echo "> Stashing your workspace..."
    git stash > /dev/null
    echo "> Unboxing your staging area..."
    git reset HEAD~ > /dev/null
    git add -A > /dev/null
    echo "> Rebuilding your workspace..."
    git stash pop
  else
    echo "> Workspace is clean, so just re-staging those."
    git reset HEAD~ > /dev/null
    git add -A > /dev/null
  fi
fi

echo "> ${GREEN}All set!${NC}"
