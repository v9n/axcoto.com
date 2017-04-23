+++
date = "2017-04-23T01:23:48-07:00"
title = "Format date with linux"
draft = false

tags = [ "linux", "date", "day", "bash", "linux-daily" ]
categories = [
  "DevOps",
]
+++

Time is part of DevOps life. We use timestampt everywhere, in backup, in
cronjob, compare different between two times. However, working with
date/time in bash maybe a bit cumbersome.

On Bash, lots of time, we have to rely on an external utility and use
the output to feed into another variable. That's Linux way.

The command we are looking at is `date`. It's extremely powerful.


The most basic use is just call it:


```
$ date
Sun Apr 23 08:27:40 UTC 2017
```

This is useless most of time. We can format it by passing the format
string as firt argument.

Format is to epoch

```
$ date +%s
1492936099
```

Format it as we always do with our language:

```
$ date +%Y-%m-%d
2017-04-23
$ date +%D
04/23/17
$ date "+%Y-%m-%D %H:%M:%S"
2017-04-04/23/17 08:30:08
```

What happen if we want to get yesterday time, tomorrow, 5 hours ago, as
we always do in Rails

```
5.minutes.ago
```

Or when we want to format a specificed date, not current day time. We
can pass an `--date` parameter:

```
$ date "+%Y-%m-%D %H:%M:%S" --date=now
2017-04-04/23/17 08:31:51
```

Let's do time travel:


```
$ date "+%Y-%m-%D %H:%M:%S" --date=tomorrow
2017-04-04/24/17 08:32:02

$ date "+%Y-%m-%D %H:%M:%S" --date=yesterday
2017-04-04/22/17 08:32:06
```

Back to our Rails code, we love `ago`, `from now` etc. We can do that
with date as well. By default, it advance time into future, unless we
specifiy `ago`. Such as


```
$ date "+%Y-%m-%D %H:%M:%S" --date='5 minutes ago'
2017-04-04/23/17 08:29:48
$ date "+%Y-%m-%D %H:%M:%S" --date='1 hours ago'
2017-04-04/23/17 07:35:14
$ date "+%Y-%m-%D %H:%M:%S" --date='1 hours'
2017-04-04/23/17 09:35:25
```

It's suprisingly very powerful and can parse almost anything

```
$ date "+%Y-%m-%D %H:%M:%S" --date='next monday'
2017-04-04/24/17 00:00:00
$ date "+%Y-%m-%D %H:%M:%S" --date='next monday 5:00'
2017-04-04/24/17 05:00:00
$ date "+%Y-%m-%D %H:%M:%S" --date='next monday 5:00pm'
2017-04-04/24/17 17:00:00
```

And finally, don't forgot to

```
man date
```

to learn more about what it can do.
