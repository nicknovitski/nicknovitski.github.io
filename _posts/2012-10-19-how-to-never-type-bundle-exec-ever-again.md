---
layout: post
title: How to Never Type `bundle exec` Ever Again
category: ruby
---
## Step 1: Upgrade RubyGems
    gem update --system

As I write this, the latest version of RubyGems is 2.4.5.  It retains
compatibility with Ruby 1.9.3, 2.0.0, and 2.1.x.  If you're still on 1.8.7,
focus on fixing that.

If you're worried about a RubyGems upgrade breaking something in your system,
and your system is not doing low-level gem-related hackery, then you should
stop: RubyGems is a ubiquitous part of the standard library, and thus lives
under extremely strong pressure to retain backwards-compatibility.

## Step 2: make RubyGems Gemfile-aware
    export RUBYGEMS_GEMDEPS=-

Starting with version 2.2.0, setting this environment variable to `-` causes
RubyGems to automatically recurse through the working directory and its
parents, looking for a `Gemfile` or `Gemfile.lock`.

If you're worried about this feature being half-baked, well, it was, but it isn't anymore.

NB: 
```shell
RUBYGEMS_GEMDEPS=/var/app/Gemfile /var/app/bin/serve
```

Once upon a time people used rvm gemsets to .  Then we realized we could just use bundler.  Now I'm telling you can 

## Step 3: There is no Step 3, but I'll use some space to give details

This solution works with system Rubies, every version manager I've tried.

I'm 


## Step 4: Again, there is no Step 3, so there is definitely no Step 4, and instead I'll talk about the history of my hatred of this 

One of the cleverest things that Giles Bowkett  put it that he made 

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
