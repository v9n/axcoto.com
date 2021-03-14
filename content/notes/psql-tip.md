+++
date = "2017-05-21T11:02:05-07:00"
title = "PSQL tips"
draft = false

tags = [ "docker", "development" ]
categories = [
  "Development",
  "DevOps",
]
+++

I like `psql` a lot than a GUI, everything is just on your finger tips
and every single time when I used it, I build up my memory which
definetely help when inspecting/debuging Postgres in production.

## Passing credential via env

Typing password everytime is painful. Using environment var is a better
way because when pairing with a password manager I can fetch them from
my terminal and have `psql` immediately login

```
export PGHOST=localhost
export PGUSER=username
export PGPASSWORD=password
```

It's really useful when using in a headless manner such as in script or
a cron where noone is there to type in a password.

If you have multiple postgres server, you can put a file in `~/.pgpass`
with these content

```
# follow this format
# hostname:port:database:username:password
localhost:*:*:postgres:postgres
```

Then later on simply do `psql -h server` and you're in.

## History

Want to see what did you run, use `\s` to see your history. If you want
to save it some some file `\s filename`

## Run command from file

\i filename

## Timing

On Linux, we have the command `time`. Prefix it with command will let
you know how long a thing take to run. Example

```
time curl https://hanami.run
curl https://hanami.run  0.02s user 0.01s system 3% cpu 0.833 total
```

We can do the same with psql using `\timing`. After you type that
command, any SQL query will report it time at the end. If you no longer
want time reporting, enter `\timing` again.

```
# \timing
Timing is on.
(@localhost:5432) 03:52:19
# select * from foo;
 id | name
----+------
  1 | john
  2 | jane
(2 rows)

Time: 2.740 ms
```
