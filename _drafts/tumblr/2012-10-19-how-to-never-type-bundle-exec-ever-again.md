---
layout: post
title: How to Never Type `bundle exec` Ever Again
date: '2012-10-19T08:37:00+00:00'
tags: []
tumblr_url: http://nicknovitski.tumblr.com/post/33896136639/how-to-never-type-bundle-exec-ever-again
---
Step 1:

 # ~/.bundle/config  BUNDLE_PATH: .bundle/gem  BUNDLE_BIN: .bundle/bin

Step 2:

 # ~/.gitignore .bundle 

Step 3:

$ echo ''export PATH="./.bundle/bin:$PATH"'' >> ~/.zshenv

(Obviously, if you’re not using zsh, you should install it right away specify whatever shell environment profile is appropriate, such as .bashrc or .profile)
Step 4:
You’re done, forever.  Take a victory lap and try to put the gemset era of Ruby development behind you. 

$ cd myproject $ bundle Using rake (0.9.2.2) Using i18n (0.6.1) # ... Your bundle is complete! It was installed into ./.bundle/gem $ which rake ./.bundle/bin/rake $ rm .rvmrc
