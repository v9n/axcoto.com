+++
date = "2016-07-07T17:51:36-07:00"
draft = false
title = "Append hash to asset in hugo"

tags = [ "hugo", "asset", "perf" ]
categories = [
  "Development",
  "DevOps",
]
+++

Hugo doesn't has a built-in process to put a revision/hash to asset
when compile from the theme. As the result, the URL statys the
same and get cache unless we explicitly trigger force refresh. If we
can append the hash, we can let's cache forever and imrpvoe site
performance.

This is what I setup to achieve this for [axcoto.com] with a simple
bash script. It isn't scale way but it's a good start when we just
need to whip up something.

Our goal: Let's append a md5 hash of file content in CSS. Let's say
instead of `css/main.css` we now have `css/main-md5-hash-here.css`.

Add this in a `makefile`:

```
CSS_DIR = public/css
CSS_FILE = $(CSS_DIR)/main.css
CSS_REV = main-$(shell md5 -r $(WORKDIR)/$(CSS_FILE) | awk '{print
$$1}').css

server:
hugo server --servertheme=axcoto --buildDrafts --watch

asset:
  cp $(CSS_FILE) "$(CSS_DIR)/main-$(shell md5 -r $(CSS_FILE) | awk '{print $$1}').css"
  find public -name "*.html" -print0 | xargs -0 -I filename /bin/bashh -c "echo filename; sed 's/css\/main.css/css\/$(CSS_REV)/g' filename > tmp; mv tmp filename"
```

We simply copy the css file and append the `md5` hash. We have to
redirect output of `sed` since I don't know a way to replace inline with
sed on Mac.

Now, after generate content, we simply run:

```
make asset
```
