+++
date = "2019-04-03T01:26:22-07:00"
title = "Mock setting in Django"
draft = true

tags = ['django', 'mock']
+++

Sometimes I has to write certain thing that should never run in
production. Such as some cleanup tasks for dev/qa.

I rely on certain `APPENV` to detect app environment. Imagine in setting
file:

```
# settings.py
APPENV = os.environ.get("APPENV", "DEV")


# files.py
from django.conf import settings
if settings.APPENV == "PROD":
    return
```

To write test for these I need to change settings, and revert to its
original value when finishing. Django has a great utility for that.

Enter `override_settings`. You use it like this:


```
# test_app.py
from django.test.utils import override_settings
from django.conf import settings

@override_settings(APPENV="PROD")
def test_foo():
    print(settings.APPENV)
    # PROD
```

Small thing but very helpful
