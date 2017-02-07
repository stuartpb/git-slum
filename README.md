# git-slum

slightly less unhelpful message

## the idea

a Bash script that, given a commit or a current working directory state, generates a commit message that basically just rephrases the output of `git status`, the way the default commit messages on GitHub work.

## use case

```sh
git config alias.autocommit '!git add -A && git commit -m "$(git-slum)"'
```

also: using this with rebase to make your commit messages only as bad as they would have been via GitHub instead of "asdf stuff"

## TODO: get this integrated into Git as an option to `git status` and/or describe or log or whatever

the `--slum` option stands for Single Line Update Message, and describes the status in a single line.

## faq

### Q: WOW!! This looks really helpful!!! Should I use this in all my projects everywhere I'm going to use it everywhere!!!!!!!

**No.** Write actual commit messages. There's a reason Git doesn't have a convenient shorthand for the `--allow-empty-message` argument. [A history that's just the diff statistics without a *description* of the actual change](https://github.com/stuartpb/git-slum/commits/master) means you have to do a lot more work to understand anything that's going on *inside* those changes, and is barely better than no commit messages at all.

That said, sometimes there's really only one kind of change that happens in a repo (ie. a repo where there's only one kind of update that you can make to a file), and in *those* projects, a tool like this makes sense. However, in *most* projects, it's bad, and you shouldn't do it.
