---
layout: post
title: Tabletop, an rpg/boardgame DSL, and my first Ruby gem
date: '2011-08-13T22:27:35+00:00'
tags:
- rpg
- ruby
- tabletop
tumblr_url: http://nicknovitski.tumblr.com/post/8896942353/tabletop-an-rpg-boardgame-dsl-and-my-first-ruby-gem
---
Tabletop, an rpg/boardgame DSL, and my first Ruby gemIf you know what all that means, the linked readme will tell you more, so for the purposes of this post, I’ll assume you don’t.
A DSL is a “domain-specific language.”  It means a programming language that’s designed to fit a certain sphere of knowledge: it should be easily learned and understood by anyone who’s familiar with that sphere, and it should do a bunch of convenient things for them, without a lot of fiddling or repetition.
Some DSLs are written “inside” other programming languages.  Like this one, which is written in Ruby.  Don’t worry if you don’t know Ruby: the whole point of a good non-technical DSL is that you don’t need to learn a complete programming language to use it.  Check out the readme at the link, you’ll see a lot of the syntax is pretty straight-forward stuff.  My goal is that, if you can remember to put a period in your dice notation (“2d6” => ‘2.d6”), then you, too!  Can use Tabletop!
Except…well, since it’s written in Ruby, you’ll need a Ruby interpreter on your computer to run it.  You may already have one (what-up, mac brosephs), but you may need to get one.  And even once you do, you’ll also need to get and install the code for Tabletop itself!  But don’t worry!  That’s much less troublesome than it sounds, because I packaged the whole thing up in something called a “gem,” and once you’ve got Ruby, you can install the latest version of Tabletop by running the command “gem install tabletop”!
Then you’ll want to read the linked readme.
In case you’re wondering: I wrote it for the same reason that anyone writes a computer program in their spare time: computers are powered by genies who exist to fulfill my every whim, and must be reminded of this fact at length.
