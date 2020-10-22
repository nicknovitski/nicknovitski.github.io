---
layout: post
title: Reimplement `npm install -g` with nix and bash
permalink: /nix-npm-install
---

I recently happened upon [write-good](https://www.npmjs.com/package/write-good).  I wondered if it could help me write this very blog.  Well, it did, though probably not in a way the author could have forseen...

# The Problem
Somehow - from a blog post, tweet, or lightning talk - a command-line tool comes to your attention.  The description leads you to hope it might solve a problem for you.  So, you quickly install it and...

Ah, the installation instructions say `npm install -g this-package`.  But you don't have a global installation of npm.  You use nix, which lets isolated package sets, package versions, node versions, and everything else, coexist on the same system without complaint.  You will never go back to the bad old days of globally installing language-specific package managers, much less language-specific packages!

<aside>(If that isn't you yet, you'll get more value from reading <a href="https://nixos.org/nix/manual/#chap-introduction">an instroduction to nix</a> than this post, but bookmark it and come back later when the time is right.)</aside>

But this is different: we're talking about a command-line tool which happens to be written in a particular language.  And nix is a perfect match for this kind of thing: a package definition for this tool could automatically install every dependency it needed, but _only_ add the tool itself to your $PATH, hiding npm and node themselves as implementation details.

In fact, if the tool is very popular, it might already be in nixpkgs.  [The list](https://github.com/NixOS/nixpkgs/blob/master/pkgs/top-level/node-packages.json) includes browserify, cordova, webpack, yeoman...

But let's say it doesn't include the package you're after.  At this point, you could submit a patch to add that package.  It looks like it'd be pretty easy, too: just add a line with the package's name to that list, and then run the `generate.sh` command in the same directory to update the nix files which define the source and dependencies for the whole included set of node packages.

And then you'd wait for it to be merged, and wait for the merge to show up in the release channel you're using...all that work and waiting!  You just wanted to try this thing out!  You don't even know if it'll help you yet!

What you want is a single command that works just like `npm install -g`, but uses nix under the hood.  Given the name of some package on npm, it will look up the latest version of that package, all of its dependencies, and the sha256 hashes of every source archive it needs to download, and then install the whole thing in your current profile.

# The Solution

Let's take a look in that `generate.sh` script:

```bash
#!/bin/sh -e

rm -f node-env.nix
node2nix -i node-packages.json -o node-packages-v4.nix -c composition-v4.nix
node2nix -6 -i node-packages.json -o node-packages-v6.nix -c composition-v6.nix
```

It's using a project called [node2nix](https://github.com/svanderburg/node2nix) to turn that file with an array of package identifiers into complete package definitions.  If you clone down nixpkgs and run the script, you'll see that it queries npm's api for each package's latest version, all of its dependencies, and the sha256 hashes of every source archive that would later need to be downloaded, and then creates the nix files with everything `nix-env -i`, and therefore our dream command,  would need!

So, how do we make `ourcommand foo` run `node2nix` on a file containing `["foo"]`?

```bash
#!/usr/bin/env bash
node2nix --input <( echo "[\"$1\"]")
```

Here's what's happening, step by step:
- the `--input` option is just the long form of the `-i` you saw in `generate.sh` (I prefer to use long-form options in all my scripts)
- bash replaces `<( $command )` with the path to a file descriptor which contains the output from running `$command`
- `echo "[\"foo\"]"` outputs `["foo"]`
- bash replaces `$1` with the first argument you pass the script: the name of the package
- unlike in `generate.sh`, there's no `-o` option, which means node2nix will simply `o`utput a `default.nix` file in the current directory

But, if you try this out, the script will just dump a bunch of nix files in whatever directory you run it.  Inconvenient, and incomplete!  Let's put them somewhere in `/tmp` instead, so they'll never overwrite or clutter anything you're working on.

Further, let's, like, you know, _actually install them_.

```bash
#!/usr/bin/env bash
tempdir="/tmp/nix-npm-install/$1"
mkdir -p $tempdir
cd $tempdir
node2nix --input <( echo "[\"$1\"]")
nix-env --install --file .
```

This script does everything that we wanted, but it also leaves us in a temp directory we no longer need.  Let's fix it to always take us back where we started, using a matched pair of commands which seem made for that purpose.

```bash
#!/usr/bin/env bash
tempdir="/tmp/nix-npm-install/$1"
mkdir -p $tempdir
pushd $tempdir
node2nix --input <( echo "[\"$1\"]")
nix-env --install --file .
popd
```

But wait, those of you playing along at home may have noticed an ironic new problem: this script itself depends on our having globally installed node2nix!  That's both totally normal for scripts, and totally crap.  We're nix users: we can do better.  In fact, we can do better in two different ways.

The first is to change the shebang of the script from `bash` to `nix-shell`.  This lets us write scripts that download their own dependencies. In this case, all we need is node2nix, which thankfully is already in nixpkgs.

```bash
#! /usr/bin/env nix-shell
#! nix-shell -i bash -p nodePackages.node2nix
```

The `-i` argument specifies what `i`nterpreter the script needs - in this case, bash - and the `-p` argument says what nix `p`ackages the script needs in its environment - in this case node2nix.  Just put that script anywhere you like in your `$PATH`.

But manually moving scripts around is scrub-tier garbage.  The second and superior way to solve the dependency problem is to _install the script itself as a nix package_.  I know, I know: we were doing all this to avoid writing packages, but I swear, it's almost as simple as adding those same six lines of bash directly to your package overrides in `~/.nixpkgs/config.nix`:

```nix 
{
  packageOverrides = super: let pkgs = super.pkgs; in {
    nix-npm-install = pkgs.writeScriptBin "nix-npm-install" ''
      #!/usr/bin/env bash
      tempdir="/tmp/nix-npm-install/$1"
      mkdir -p $tempdir
      pushd $tempdir
      ${super.nodePackages.node2nix}/bin/node2nix --input <( echo "[\"$1\"]")
      nix-env --install --file .
      popd
    '';
  };
}
```

And that, with only a few changes, is what I use today.

```bash
$ nix-env -i nix-npm-install
# [snip nix noise]
$ nix-npm-install write-good
# [snip more nix noise]
installing ‘node-write-good-0.11.0’
$ write-good _posts/2017-04-22-nix-npm-install-g.md
# [snip all my weak writing]
```

# Limitations and Future Work

Now, just like npm itself, this script won't work on any packages that have some kind of non-node system dependencies.  And there are many ways this basic version can be improved: why not always use a fixed and more recent version of node than node2nix sets by default? Why not implement subcommands, so we could call `nix-npm uninstall foo` instead of remembering we need to do `nix-env -e node-foo` instead?

And why not write a matching script that does the same thing for the other common language-specific package managers, like, say rubygems?

Well, I've done that last part, at least.  Next time.
