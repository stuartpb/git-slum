# git-slum: slightly less unhelpful message

`git-slum` is a Bash script that takes the output of `git diff --name-status` and converts it to a one-line summary of the file operations, akin to the default commit subjects provided when making changes on GitHub.

The script as written depends on [at least one Bash-4-ism][line 16]: to use it in an environment with an older version of Bash (ie. macOS), you'll either need to rewrite this script, or install a newer version of Bash (eg. via MacPorts or Homebrew).

[line 16]: https://github.com/stuartpb/git-slum/blob/d5125e1df0461a1258d1544fead7beb9f5677f02/git-slum#L16

## Use cases

### Add an autocommit command to Git

```sh
git config alias.autocommit '!git commit -am "$(git-slum HEAD)"'
```

### Cleaning up ugly commits

You can clean up bad placeholder commit messages by pasting `exec` lines amending them to the todo list in `git rebase -i`:

```
pick d703f1559614cce741d9107086fc0f608feb6fa3 Create main loop & timing control
pick 5ededd319c78363702166e845168ad8258b52ee0 adkfjslkdfjsdklfj
exec git commit --amend -m "$(git-slum HEAD^ HEAD)"
pick 960570b166db94c6fcd32de11225ebc81dadd4d8 Enable config file parsing
pick e3e578ecdcd6eefe994f6e54714bc03c270f911a Misc bugfixes
pick 1f1732d2ce193b0f740a84e553b848394a59a055 Code additions/edits
pick 09ce7c329d0550c5869d56ad24d055707920196e my hands are typing words
exec git commit --amend -m "$(git-slum HEAD^ HEAD)"
pick 74bc87f478fc36bea78813de7a587a16f131a6b5 haaaaaaaaands
x git commit --amend -m "$(git-slum HEAD^ HEAD)"
pick fb77b6cf301971fca1b841b3744ee85e9b37a736 Crib from https://xkcd.com/1296/
```

(That said, commits like these are generally better squashed away altogether - you may want to take a look at the [`--squash` and `--fixup` options to `git commit`](https://git-scm.com/docs/git-commit#git-commit---fixupltcommitgt).)

## FAQ

### Q: WOW!! This looks really helpful!!! Should I use this in all my projects everywhere I'm going to use it everywhere!!!!!!!

**No.** Write actual commit messages. There's a reason Git doesn't have a convenient shorthand for the `--allow-empty-message` argument. [A history that's just the diff statistics without a *description* of the actual change](https://github.com/stuartpb/git-slum/commits/slummed/master) means you have to do a lot more work to understand anything that's going on *inside* those changes, and is barely better than no commit messages at all.

That said, sometimes there's really only one kind of change that happens in a repo (ie. a repo where there's only one kind of update that you can make to a file), and in *those* projects, a tool like this makes sense. However, in *most* projects, it's bad, and you shouldn't do it.
