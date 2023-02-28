+++
date = "2023-02-28T00:27:16-08:00"
title = "Auto Confirm AWS Cognito User"
draft = false

tags = ['aws', 'auth', 'cognito', 'tip', 'short']
+++

By default when creating a user in Cognito use the Admin API Create
User the user will be required to changed the temporary password(even if
the temporary password was set  by us).

To auto confirm the user(such as when manually create admin user through
some admin panel) we simply need to set a permanent password by making
this call:

```
aws cognito-idp admin-set-user-password
        --user-pool-id us-west-2_123 \
        --username 'user@example.com' \
        --password awesome-password \
        --permanent \
        --region=us-west-2
```

Upon making that API call(can be done through boto), the user password
is permanent and auto confirm, they can also login with that password
immediately without being asked to changed.