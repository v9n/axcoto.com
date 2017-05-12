+++
date = "2017-04-23T12:23:34-07:00"
title = "awk tip"
draft = false

tags = [ "awk", "sort", "text processing", "duplicate" ]
categories = [
  "Development",
  "DevOps",
]
+++


AWK is a powerful tool to process text data. In it, we can do control
structure, loop, math calculatio like a real programming language.

## Tips

Let's say we have a csv file of 2 columns, we want to create a new
columns. We an do that as this:


```bash
awk -F, '{$3=$1"-"$2; print}' file.csv
```

Sort by frequency

```
  cat $f/user.log | sort | uniq -c | sort -nr > $f/user_uniq.log
```
