+++
date = "2016-11-09T21:18:32-08:00"
draft = true
title = "Mongoid autoload relations data"

+++

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
