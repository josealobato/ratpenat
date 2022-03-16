# Use a git commit message template

* Status: accepted
* Deciders: Jose A Lobato
* Date: 2022-03-16 

Technical Story: https://github.com/josealobato/ratpenat/issues/1

## Context and Problem Statement

We want to be consitent on our commit messages.


## Decision Outcome

The project includes a file called `.git-commit-message-template.txt` that provides a template to give consistencies to commits.

The initial version constains:
```
WIP issue #
<Subject line (try to keep under 80 characters)>

<Multiline Description>

issue #
```

Use just the first line to create a quick commit.

To enable this feature add the following configuration to your repo `.git/config`:

```
[commit]
	template = .git-commit-template-message.txt
```

You can do that manually or by running the command:

`git config commit.template .git-commit-template-message.txt`

This will instruct to your locall clone to use that template when creating a new commit. 

When you type `git commit` the editor will open with the template on it.

You can skip the template by directly typing the message on CLI like this:

`git commit -m "My great commit"`

This is useful when you want to do a quick WIP commit.

