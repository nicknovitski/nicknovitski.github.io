---
title: One Magic Line of Code that fixes Nix syntax highlighting in Vim
permalink: /vim-nix-syntax
layout: post

---

Say you use Vim, and say you've decided to finally look into this
[Nix](https://nixos.org/nix) thing you keep hearing about.  You open up
some package definition files, and you immediately notice that there's no
syntax highlighting.

That makes sense: Nix is a relatively new language, so why would Vim ship with
a plugin for it?  You're up for trying out bleeding edge stuff, so you know
what to do: ask your preferred search engine what plugin the community uses.

If that's what brought you here: the best Vim plugin for looking at Nix code is
[vim-nix](https://github.com/LnL7/vim-nix).

So you install vim-nix through your favorite plugin manager (or at least your
current favorite), and you start looking through
[nixpkgs](https://github.com/NixOS/nixpkgs), and writing your own
packages, and it's great.  The isolation makes environment-specific build
errors a thing of the past, the caching and binary substitution speeds up builds
and deploys more than you could have hoped.  You want to
run your laptop on it, and your company. You want it everywhere, and to tell
everyone about it.  Your productivity and peace of mind skyrocket, you become a
leader in your field, and all of your conference talk proposals are accepted
everywhere, forever.

But at some point in this glorious trajectory, you started installing Vim _via_ Nix,
and soon afterwards, you begin to notice a few problems with the syntax
highlighting.  Small ones, yes, and superficial...but noticeable, and
eventually even bothersome.

  - Identifiers with `-` characters in them are painted two wrong colors rather
    than the single correct one.
  - Indented strings are unpredictably painted in inverted colors, as if
    everything _outside_ them was the string, and everything _inside_ them was
    the Nix code.
  - Double-single-quotes inside of double-quoted strings are painted as if they
    were the beginning of an indented string, which either appears to run the
    full length of the file, or to stop at the beginning of an actual indented
    string, triggering the inverted indented string situation mentioned in the
    previous bullet point.
  - Escaped antiquotes look exactly like unescaped ones.

"Huh," you mutter with strained charity, "I guess vim-nix still needs some work."

NO.  WRONG.  FALSE.  It does _not_ need work.  _You_ need the Magic Line of
Code.  Without it, _you aren't even using vim-nix_.

Here it is:

```nix
vim.ftNix = false;
```

That's it.  That's all that you were missing.  Add those 18 characters to
your `~/.nixpkgs/config.nix` and it will fix every single one of the above
problems.

Here's what happened: at some point you realized that you could manage your Vim
plugins and configuration by writing them into a Nix package.  Every source on
the matter told you the same thing: the function `vim_configurable.customize` will
return a package with your own unique, customized Vim setup.

Here's the simplest example of what that looks like:
```nix
vim_configurable.customize {
  name = "myVim";
  vimrcConfig = {};
};
```

`customize` requires two arguments: the `name` of the executable for the new
package, and a set describing the `vimrcConfig` that will make this Vim package
different from the default `vim_configurable` one.  The example here just uses an
empty set (`{}`), but yours will be full of plugins and `vimrc` lines.

(The `vimrcConfig` argument should probably be optional, but no one's
gotten around to making that change yet.  Maybe that could be your first
contribution to [the nixpkgs
repository](https://github.com/NixOS/nixpkgs)?)

Having learned how to create this package, you wanted to install it with
`nix-env --install`.  To make environment.  To make new packages available to
the `nix-env` command no matter where you invoke it, you need to have a file at
`~/.nixpkgs/config.nix` which evaluates to a set that has a `packageOverrides`
attribute, the value of which is a function that takes your system's `nixpkgs`
as an argument and returns a set of packages to add or change.

Here's what that looks like with our simplest-possible-custom-vim package.
```nix
# ~/.nixpkgs/config.nix
{
  packageOverrides = super: {
    myVim = super.vim_configurable.customize {
      name = "myVim";
      vimrcConfig = {};
    };
  };
}
```

So with that, `nix-env --install myVim` will add the `mvVim` executable to your
environment, and you're off to the races.

NO.  STOP.  WAIT.

Any package you create from the `vim_configurable.customize` function will by
default have some basic Nix syntax highlighting built in.  This is the
imperfect highlighting behind all those annoying glitches I listed before.
It's convenient for occasional edits, but you deserve the best; you deserve vim-nix.

So you add it as one of your plugins.  Here's the absolute simplest way to do
that, just changing a single line:
```nix
# ~/.nixpkgs/config.nix
{
  packageOverrides = super: {
    myVim = super.vim_configurable.customize {
      name = "myVim";
      vimrcConfig.packages.thisPackage.start = [ vimPlugins.vim-nix ];
    };
  };
}
```

That changed line means that `myVim` will load vim-nix as soon as it starts,
which is what we want.

(More precisely, it means that `myVim` will have a line in its `vimrc` which sets
its `packpath` to be a directory containing `pack/thisPackage/start/vim-nix`,
but for those kinds of details you can read the source of the `customize`
function, and/or call `:help packages` from inside Vim.  Or just contact me,
because I wrote this one small part of nixpkgs.  :sweat_smile:)

But it's not _all_ of what we want, because that basic syntax higlighting?  The
one I mentioned that `vim_configurable` includes by default, and which has all
those problems?  Guess what, you're still using it, not vim-nix.  It takes
precedence over any other plugin defining a Nix filetype.

So by now you get it: the Magic Line of Code disables the basic built-in syntax
highlighting, allowing the deluxe and flawless syntax highlighting of vim-nix
to take over.

Nix is a purely functional language, which means that only arguments to a
function can effect its output.  Every Nix package is a function which takes
all of its dependencies as arguments.  Some packages also take the contents of
your `config.nix` as an argument, and vary their behavior accordingly.

`vim_configurable` is one of these packages, and `vim.ftNix` determines whether
or not its derivations include the `f`ile`t`ype for `Nix`.

So, here, at the end of all mysteries, is the absolute minimum `config.nix`
that will let you install your own special Vim which has the Ultimate
Syntax-Highlighting Experience when looking at Nix files:
```nix
# ~/.nixpkgs/config.nix
{
  vim.ftNix = false;
  packageOverrides = super: {
    myVim = super.vim_configurable.customize {
      name = "myVim";
      vimrcConfig.packages.thisPackage.start = [ vimPlugins.vim-nix ];
    };
  };
}
```

I'd like to thank Daiderd both for their contributions to vim-nix, and for
[pointing out the real problem
](https://github.com/LnL7/vim-nix/issues/11#issuecomment-291292195) when I came
barging into his github repository with a bogus issue.  Hopefully this can save
you all from such embarrasment.
