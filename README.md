A bunch of tools I am accumulating to help do console stuff.

As a note I suck at bash and am really just learning.

Some of this is pretty brittle and should be used with a grain of salt.
All of this is hacked together without deep thought.

Some tools:

/git:
  wip-swap.sh:
    A tool that will recklessly auto-commit any unstaged changes, untracked files, etc to a commit marked @@WIP before swapping to another branch. If the landing branch happens to have a @@WIP commit, it will pop it off and leave all changes unstaged for you to figure out yourself. Takes a branch name as a parameter. If the branch doesn't exist this probably just breaks.

    Future improvements:
    - Always check to see if the branch exists first
    - Give fuzzy branch suggestions in case the branch doesn't exist
