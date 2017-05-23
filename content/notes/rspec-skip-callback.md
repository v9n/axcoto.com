+++
title = "rspec skip callback"
draft = true
date = "2017-05-23T12:08:03-07:00"

+++

ActiveRecord/Mongoid encourages using of callback which leads to lot of
issue when testing. Let's be honest, we're all been there.

It's really ugly but what I come to use is a combination of FactoryGirl
callback.

I will first disable Mongoid callback, then manually trigger only
callback that I want with FactoryGirl

```
    after(:build) do
      Model.skip_callback(:create, :after, :cb1)
      Model.skip_callback(:create, :after, :cb2)
    end

    after(:create) do |r|
      r.cb1 # manually call cb1
    end
```

Using in combination with `FactoryGirl Inheritance`, we can make it a
bit nicer


```
factory :with_call_back do
  # attbs

  after(:save) do |m|
    m.callback
  end

  factory :with_out_cb do
    after(:build) do
      Model.skip_callback(:create, :after, :cb1)
    end
  end

end
```
