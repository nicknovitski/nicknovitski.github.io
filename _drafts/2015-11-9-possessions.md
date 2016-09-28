---
layout: post
title: Possessions
---

My sister once called me "our priest of minimalism," 
This really surprised me for a
moment, because I don’t feel especially minimalist, but I quickly understood
her: I’m one of the most minimalist people which she can still _understand_.
In my view, someone minimalist enough to merit a religious title would carry
all of their physical possessions on their person, or produce a significant
percentage of their own food.  

But my sister has My sister has two children, and .  Really, someone who was raising even one kid could have 

the sliding scale

we all feel average to our selves 
- Rich: someone with an order of magnitude more money than I have.
- Strong: someone who has been training an order of magnitude longer than I have.
- Minimalist: someone who owns a tenth as many things as I do.

i don't even know how many things I have.

Intersecting lives are full of these partially intersecting scales.  At work, I feel surrounded by developers who are at _least_ as good as I am, and I fill my in-feeds with those who far surpass me.  But Because the people I pay attention to on the subject fitness are stronger than I may ever be, I feel like an eternal beginner But still, at some point, in certain gyms, strangers started to make jokes about the weights I was moving, and I have to accept that I am, if not healthier, at least stronger 

There have been measured .  Being the worst person in the best group that still allows you in is an excellent strategy.

I think wealth may be an exception, or at least, more complicated - children who grow up in wealthier neighborhoods have better outcomes (yes, controlled for family income, what kind of monster do you think i am (citation needed)), but people whose friends are all richer than them seem to say a lot of things like “between the gardeners and the nannies, $250,000 a year is barely enough to get by”.

if you hang out around people who you are much better off than, maybe you’ll feel more grateful, or maybe you’ll just get depressed

How about organize your shit so that you will probably succeed along assorted metrics, and then do specific exercises for gratefulness, happiness, etc

You may have noticed the minimalist trend.  

of counting your possessions.  To this day I still don’t know how many discrete physical _things_ I own - every attempt to count them gets derailed by a project

Recently, when I should have been thinking of something else, I happened upon a method for the logical organization of my possessions which had some immediate benefits.

by this i don’t mean _physically_ organizing them in some reasonable way - I assume you already do this, storing things close to where you use them, allowing frequently-used things to occupy the most reachable spots.  When programmers use the adjective “logical”, they mean “conceptual”.  So by “logical organization”, i’d really just mean how you organize _the way you think_ about your possessions, or how you write down a list of them. 




but there is a far more pervasive and mainstream cult, one of _moderation_

growing up with a grandfather with a very advanced alcoholism, and parents who drank wine all the time, without any mysticism or stern forbidding, combined to make me respectively quite worried by alcohol, and quite satisfied without it.  thus i did not drink any alcoholic beverage until i was twenty-two.  I had been at college for some time without feeling any need or pressure to drink, when at a party, a friend saw me across the room, strode over, and immediately launched into what remains, to this day, the longest single speech I ever heard him make.  

“Mr. Novitski, I was thinking of you today, and how you said because of your family history, you choose not to drink alcohol, and I respect that decision, but I also thought of Aristotle.  You know, Aristotle points out that for almost every human quality, you can have too much of it: there’s such a thing as being too brave, or too generous…you do

so i was thinking, I believe, that there is an ideal amount of alcohol consumption for you, and it _may_ even be zero, but there’s no way to actually know unless, and that you’ve even given the situation as much thought as you have, makes me think that _trying_ alcohol does not pose any risk.”    

I could give no counter-argument to this.


“I basically became homeless in my own city. Logically, the next step would be to become homeless in the world!”

Grab a possession, and ask yourself what outcome it helps you produce.  Then list every other possession which also serves that affordance.  Consider each cluster.  That’s it.  I immediately saw i was keeping way too many objects for the amount of cooking i did, and I either had to cook more or get rid of them.  
I've decided to list everything I own.  Weird, right?

The links are just for me, so I can get rid of things more easily.

{% for p in site.data.possessions %}
  1. {{ p.name }}
  {% unless p.keep %}
  ([sell on ebay](https://csr.ebay.com/cse/start.jsf?title={{ p.name | cgi_escape }}))
  {% endunless %}
{% endfor %}
