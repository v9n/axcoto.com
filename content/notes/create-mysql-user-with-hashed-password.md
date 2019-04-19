+++
date = "2019-04-10T01:52:04-07:00"
title = "Create mysql user with hashed password"
draft = false

tags = ["devops", "mysql"]
+++

Creating MySQL account to grant other dev read-only access to a database
a common task. How can we securely share user password? It makes no
sense for the operator to know this password. It's personal password of
the user whom operator is creating an account for.

### Ask user to generate a hash of their password

User can use their own MySQL console and run this query:

```
select password('password-of-your-choice')
```

Now they give that hash to operator. Operator know the hash, not the
password(but they can still brute force it I guess, but still, not a raw
plaintext password).

Operator then create an account use this hash:

```
GRANT ALL ON *.* TO username identified BY PASSWORD 'hash-above'
```

Of course, you need to adjust `grant` to match user permission but the
idea is to use `grant` for creating user and set permission and hash at
same time
