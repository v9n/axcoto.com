+++
date = "2016-12-15T17:36:32-08:00"
title = "Ruby compare time in test"
draft = true

+++

## Comparing time in test

Recently I have code to build a hash from object. One of the feature is
it accepts string `year.ago` and turn this into a time object.

So during test, I may write something like this:

```
filter = Filter.create(operand: 10, modifier: 'year.ago')
test_method(filter)
```

This produce a hash looks like this:

```
hash = {"$lt" => 10.year.ago }
```

To test, I compare it with the real hash:

```
expect(hash).to eq("$lt": 10.years.ago)
```

Which was wrong because it get evaluate at the time it call so they
have some millisecond diff.

To solve this, I use `Timecop`

```
Timecop.freeze(Time.now) do
  # now no matter how many time you call 10.years.ago
  # it yields same result
end
```
