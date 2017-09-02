+++
date = "2017-05-25T15:50:23-07:00"
title = "mongodb aggregate tip"
draft = true

+++

When using mongodb aggregate, the limit only works for the whole data
pass to it, It doesn't work on the `group` data. Such as similar
function `reduce` of RethinkDB.

Let's say we group and push to an array like this:

```
aggregate([
  {
    $group: { _id: {"name": $name}, docs: {$push: '$$ROOT'} }
  }
])
```

If we use `limit`, it works on the whole group thing as a single
document. How do we limits only first 5 element in `docs`.

The tricks to this is `$slice` in a projection step:

```
aggregate([
  {
    $group: { _id: {"name": $name}, docs: {$push: '$$ROOT'} }
  },
  {
    $group: { _id: {"name": $name}, docs: {$push: '$$ROOT'} }
  }

])
```


```
