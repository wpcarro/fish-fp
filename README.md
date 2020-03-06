# fish-fp

![fish-fp in action][ss]

The core information that `fish-fp` displays is organized into two categories:
1. Machine information:
   - Who is the current `$USER`?
   - What is my `hostname`?
   - Is my shell connected to another host via `ssh`?
2. File-system information;
   - What is my current directory?
   - Is my current directory part of a git-controlled repository? If so:
     - What is the name of the repository?
     - What is the name of the currently checked-out branch?

Additionally, `fish-fp` colors the prompt when a previous command exits with a
non-zero exit code. The lambda sigil becomes a `#` when the current `$USER` is
root.

## Design Goals

Some prompts aim to support dozens of applications. I find these prompts
impressive to look at but too noisy for me to reliably parse. With `fish-fp`,
I'm aiming to create a prompt that satisfies the following design goals:

1. Thin: I want my prompt to fit within 80 characters.
2. Spacious: `fish-fp` spans two lines so that the commands that you type can
   fit on one line.
3. Minimal: I'm not interested in encoding a maelstrom of information like
   my current versions of`docker`, `virtualenv`, `node`, `ruby`, `elixir`, `go`,
   `kubernetes`; laptop battery information; stock market prices; status of the
   nearest coffee machine; etc.
4. Few dependencies: If your shell can resolve `git`, `time`, GNU `coreutils`
   and your terminal can render unicode, you can use this prompt.
5. Lambda sigil: The Greeks liked functional programming.
7. Easily parsable: I want all of the information that my prompt displays to be
   in the same location at all times. Some prompts conditionally show or hide
   information; this confuses me. I want all of the information that my prompt
   renders to be visible at all times; I can more quickly and reliably parse the
   information this way. Instead of conditionally displaying information, I
   conditionally color elements.

## Installation

For now, copy-and-paste `prompt.fish` into your `config.fish`. I'm considering
packaging this with [Nix][wtf-nix]. I'll also consider packaging this with some
fish package manager if people are interested.

[ss]: ./screenshots/fish-fp.png
[wtf-nix]: https://nixos.org/nix/
