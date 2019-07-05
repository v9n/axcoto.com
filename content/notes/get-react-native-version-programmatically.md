+++
date = "2019-07-05T10:29:39-07:00"
title = "get react native version programmatically"
draft = false

tags = ['mobile', 'react-native']
+++

I recently upgrade an app to React Native 0.59. TBH, It's disaster with
so many issues came up. One of the thing is I want to display react
native version in the app so we know we have right build.


```
const rnVersion = require("react-native/package.json").version
```

That's all for today.
