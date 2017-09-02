+++
date = "2016-11-09T21:18:32-08:00"
draft = false
title = "Mongoid Pitfall"

tags = [ "mongoid", "ruby" ]
categories = [
  "development",
]
+++

## Default value and callback

I recently started to work with Rails and Mongoid. I don't have much
experience with ActiveRecord and this is the first job that I actually
use Rails.

The other day we have a query that looks like this:

```
array.each do |user_id|
  User.find(user_id)
end
```

The array contains 20 elements. And A find by id should be very fast but
above query run in ~10s.

At first I tried to turn it into something like this

```
User.where(:id.in => array).each 
```

But it is still superslow. Turning out **MongoiD** will auto load all
relations and this user has lots of association so Mongoid will fetch
all kind of relations. This array contains a list of heavy users in our
app with lots of related data.

The fix is simply:

```
User.without(:relation).find(user_id)
```

The lession is that we should always benchmark code instead of blindly
guessing which parts of code is slow. If I benchmark them right at the
beginning I would have known exactly the problem much quicker.

The second thing is default value. Value is evaluated instantly at run
time, when the file is loaded if the value wasn't a closure.

Let's say you have this:

```
field :foo, type: Time, default: Time.now.utc
```

Now, the value of everydocument will be exactly same value at the time
the file is loaded and evaluated by RubyVM.

The right way to do this is using a callback so that the value is
evaluate lazily at runtime

## Default value and search

The other day I see no data in an `admin ui` which supposed to always
have data. I fired up Rails console, and run query:

```
Check.where(type: 'http').count
```

It returns 0:

But I do see some document with that:

```
Check.first.type
```

I open the mongo shell to check real data and the field was missing.
Turning out, the `default` masked the problem, when data is missing,
default is kicked in and field it in.

