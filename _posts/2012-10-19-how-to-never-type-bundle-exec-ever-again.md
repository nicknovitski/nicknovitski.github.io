---
layout: post
title: How to Never Type `bundle exec` Ever Again
category: ruby
---
## Step 1: Upgrade RubyGems
    gem update --system
    
As of my writing these words, the latest version will work with all released 
versions of Ruby back to 1.9.3.  If you're stuck running 1.8.7, consider fixing
that first, but you may also refer to [the previous, more 
complicated version of this post](https://github.com/nicknovitski/nicknovitski.github.io/blob/4516cdf7210bc4cf780cef72627189dc3cea8671/_posts/2012-10-19-how-to-never-type-bundle-exec-ever-again.md).

## Step 2: make RubyGems Gemfile-aware
    export RUBYGEMS_GEMDEPS=-

Starting with version 2.2.0, setting this environment variable to `-` tells
RubyGems to automatically recurse upwards through the working directory and its
parents, looking for a `Gemfile`.  If it finds one, it will resolve all dependencies
and their versions, and activate them.

## Step 3: There is no Step 3, go away

That a gem is "activated" means a few things:

1. `gem install -g` on the command line will install it.
2. `require 'gemname'" in a ruby file will resolve to it.
3.  If it has a command `foo`, then `$(gem environment gemdir)/bin/foo` will run it.

If you don't have that directory in your `$PATH`, `gem install`
will print a little warning telling you exactly what to add, but you're probably using
either rvm, rbenv, or chruby; they all manage that automatically.

You don't need to type `bundle exec` anymore.  You don't need to type `bundle install`
anymore.  You don't need to type `gem install bundler` anymore.

You don't need binstubs, shell aliases, gemsets, git hooks, cd hooks, or version manager plugins.

Why are you still here.

## Step 4: As there is no Step 3, there is definitely no Step 4

You may have heard 
[this one](http://www.ted.com/talks/hans_rosling_and_the_magic_washing_machine/transcript?language=en)
before.  Here's how I tell it:

A kid's mother tells him she's going to teach him how to use their new washing machine.

First they gather all the dirty clothes in the house and pack them in.

"Now what?"

"Now we measure in the soap."

"Now what?"

"Now we set the timer and start it running."

"Now what?!"

"Now, we go to the library, and you choose out your favorite three books, and we come home, and read them together."

The moral of the story is that the washing machine is not for washing clothes; it's for *not* washing clothes.

## Step 5: Now you're really asking for it

I told that story partly because `bundle exec` makes me angry enough that I have trouble
discussing it directly. Please, for your own sake, do what it takes to stop typing it.

> It is a profoundly erroneous truism, repeated by all copy-books and by eminent people when they are making speeches, that we should cultivate the habit of thinking of what we are doing. The precise opposite is the case. Civilization advances by extending the number of important operations which we can perform without thinking about them. Operations of thought are like cavalry charges in a battle — they are strictly limited in number, they require fresh horses, and must only be made at decisive moments.
>
>- <cite>Alfred North Whitehead</cite>
