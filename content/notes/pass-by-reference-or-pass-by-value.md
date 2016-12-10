+++
date = "2016-12-09T10:58:44-08:00"
title = "pass by reference or pass by value"
draft = true

+++

When we are in school, they said it's either passing by reference or
pass by value. When pass reference, you can change the value. When pass
by value you cannot change anything.

Let's take this in Ruby

```
hash = {foo: 12, bar: 3}

def c1(h)
  c1[:foo] = 100
end
```

Run them in IRB, yield below result:

```
```
