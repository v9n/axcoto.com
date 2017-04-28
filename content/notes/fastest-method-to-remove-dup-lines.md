+++
date = "2017-04-27T12:19:23-07:00"
title = "10x faster method to remove dup lines"
draft = false

tags = [ "awk", "sort", "text processing", "duplicate" ]
categories = [
  "Development",
  "DevOps",
]
+++

Whenever talking about removing duplicate line, I always use a
combination of `sort` and `uniq` like this:

```bash
wc -l source.csv
10941092 source.csv

time sort -u source.csv | uniq > source_standarize.csv
real0m50126s
user0m40.104s
sys0m0.944s
```

However, today I learn a new trick which is 10x faster using awk:


```
time awk '!a[$0]++' source.csv

real0m9.400s
user0m5.336s
sys0m0.240s
```

So 10x faster. Let's see how this trick works

```
awk '1' file
```

1 evaluates to true, and will return everything. 

```
awk '0' file
```

will return nothing.

awk goes over line by line, evaluate and the result, if it's true, it
print out. so look at `!a[$0]++`

- `a` is just an varaible that we declate and use. 
- `a[$0]`: $0 is whole line, so we create an hash, with the line text as
  key
- a[$0]++ will incrase the value to 1
- First time a line appear, `a[$0]` return 0. Hence `!0`-> true. 
- Second time a line appear, `a[$0]` is already 2, and will increaseing.
  `!2` -> false

Hence `awk` will not print out that.
So basically this is an giant hash map
