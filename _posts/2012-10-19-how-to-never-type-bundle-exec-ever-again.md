---
layout: post
title: How to Never Type `bundle exec` Ever Again
date: 2012-10-19 08:37:00
---
## Step 1: ~/.bundle/config
    BUNDLE_PATH: .bundle/gem
    BUNDLE_BIN: .bundle/bin

This configures bundler to install gems in a `.bundle` directory at the project root.

## Step 2: ~/.gitignore
    /.bundle/

This configures git to ignore the `.bundle` directories.  The trailing slash means 'directory', and the leading slash means 'at the repository root'.

## Step 3: ~/.profile (or .bashrc, .zshenv, etc.)

    export PATH="./.bundle/bin:$PATH"

This configures our shell to look in the `.bundle` directories first when we
run things on the command line. Things like `rake db:migrate` and `rails s`.

*Update*: If you already use [rbenv](https://github.com/sstephenson/rbenv), you can skip this step by instead installing the [rbenv-binstubs](https://github.com/ianheggie/rbenv-binstubs) plugin.  That's what I do.

## Step 4: There is no Step 4

That's it: you’re done, and will never need to type `bundle exec` again.  Take a victory lap and try to put the Bad Old Times behind you.

    $ cd yourproject
    $ bundle
    Using rake (0.9.2.2)
    Using i18n (0.6.1)
    # ...
    Your bundle is complete! It was installed into ./.bundle/gem
    $ which rake
    ./.bundle/bin/rake
    $ rm .rvmrc
