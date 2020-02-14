+++
date = "2020-02-14T00:36:03-08:00"
title = "Elixir: How to cleanup dependencies from mix.lock"
draft = true

tags = []
+++

Let's say you add a new dependency to `mix.exs`, then run `mix deps.get`
The dependency are recorded in `mix.lock` now. If you change your mind,
and delete it from `mix.exs`. then it won't automatically get remove
from `mix.lock`. You have to explicitly ask `mix` to do that:


```
mix deps.clean --unused --unlock
mix deps.unlock dependency
mix deps.unlock --unused
```
