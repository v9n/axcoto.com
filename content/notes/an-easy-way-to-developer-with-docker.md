+++
date = "2017-05-21T11:02:05-07:00"
title = "an easy way to developer with docker"
draft = false

tags = [ "docker", "development" ]
categories = [
  "Development",
  "DevOps",
]
+++

When we want to experiment with some progamming language or particular
framework. It's bit painful to install them into our own development
machine. Cuz we may not end up using the language and ended up bloat our
machine.

Docker helps to reduce that pain. We can get a bash console


Example, say we want to work with Elixir, simply run this:

```
docker run --rm -it -v `pwd`:/app elixir /bin/bash -l
```

Now we have a bash session in a container with Elixir and we can invoke
any Elixir command.

Usually we want to run a web server. We can do this:

```
docker run --rm -it -v `pwd`:/app -p 4000:4000 elixir /bin/bash -l
```

Now we can run Phoeni and hit `127.0.0.1:4000` as if we were working on
host machine.

But getting run these command every time is boiler plate. Let's
intergrate them into our shell. Put this in your shell rc file, or
anywhere it can be loaded automatically.

```
docker_repl() {
  docker run --rm -it -v `pwd`:/app $@ /bin/bash -l
}
```

Now, you simple run:

```
docker_repl -p 4000:4000 elixir
docker_repl -p 3000:3000 crystallang/crystal
```

And voila, you have full access to language runtime and your code in
`/app`
