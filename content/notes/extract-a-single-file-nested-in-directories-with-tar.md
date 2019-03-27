+++
date = "2019-03-15T15:58:51-07:00"
title = "extract a single file nested in directories with tar"
draft = true

tags = []
+++

Tar is a powerful tool and when you dive deep enough, something is
doable.

Today I have this problem:

I want to download the `geoip` data and extract in a single command,
without creating temporary directories. It's easy in the old geoip, but
the new format make it harder because the file you download is a
`tar.gz` file when you extract had this structure:

```
```

How can we get out the mmdb file, it's suprising easy, use 2 options:


```
- strip: a parameter to specify how level we will strip and flatten out
- wildcards: what to extract
```

Combibe them I can do:

```

```
