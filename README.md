# git-slum

slightly less unhelpful message

## the idea

a Bash script that, given a commit or a current working directory state, generates a commit message that basically just rephrases the output of `git status`, the way the default commit messages on GitHub work.

## use case

```sh
git config alias.autocommit '!git add -A && git commit -m "$(git slum)"'
```

also: using this with rebase to make your commit messages only as bad as they would have been via GitHub instead of "asdf stuff"
