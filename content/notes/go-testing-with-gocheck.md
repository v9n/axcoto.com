+++
date = "2017-08-30T11:02:05-07:00"
title = "Go testing with Go check"
draft = false

tags = [ "golang", "unit-test" ]
categories = [
  "development",
]
+++

Using the built-in Go testing package is vey tedious and repeated.
Especially when doing DeepEqual it's requires more code.

The `gocheck` package attempt to handle that. It's use is very clean as
well.

We wrap around Go built-in test like this:

```
package thing

import (
  . "gopkg.in/check.v1"
  "testing"
)

// Hook up gocheck into the "gopkg test" runner.
func TestTheThing(t *testing.T) { TestingT(t) }

// Now we use our own Suite, I tend to think of its like context in Ruby
type SubnetSuite struct{}

// Now we actually register the suite
var _ = Suite(&SubnetSuite{})

// Define out test
func (s *Suite) TestCase1(c *C) {
}
```

The thing with `C` is it expose a nice interface to assert such as:

```
c.Assert(Foo, Equal, "bar")
c.Assert(Foo, IsNil)
c.Assert(Foo, DeepEqual, bar)
c.Assert(Foo, NotNull, bar)
```

Notice how it's very descriptive with the checker
