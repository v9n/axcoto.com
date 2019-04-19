+++
date = "2019-04-19T12:05:44-07:00"
title = "findout who lock a package in python pip"
draft = true

tags = ["python", "pip", "lock"]
+++

The other day I got an security alert promted me to upgrade urllib3. I
change them then run `pipcompile` and got hit:

```
Could not find a version that matches
urllib3<1.24,<1.25,<2.0,>=1.20,>=1.21.1,>=1.24.2,>=1.8
Tried: 0.3, 1.0, 1.0.1, 1.0.2, 1.1, 1.2, 1.2.1, 1.2.2, 1.3, 1.4, 1.5,
1.6, 1.7, 1.7.1, 1.8, 1.8.2, 1.8.3, 1.9, 1.9.1, 1.10, 1.10.1, 1.10.2,
1.10.3, 1.10.4, 1.11, 1.11, 1.12, 1.12, 1.13, 1.13, 1.13.1, 1.13.1,
1.14, 1.14, 1.15, 1.15, 1.15.1, 1.15.1, 1.16, 1.16, 1.17, 1.17, 1.18,
1.18, 1.18.1, 1.18.1, 1.19, 1.19, 1.19.1, 1.19.1, 1.20, 1.20, 1.21,
1.21, 1.21.1, 1.21.1, 1.22, 1.22, 1.23, 1.23, 1.24, 1.24, 1.24.1,
1.24.1, 1.24.2, 1.24.2
There are incompatible versions in the resolved dependencies.
```

This means some package were lock them at a lower version. How can we
quickly find them? enter `pipdeptree`

```
pip install pipdeptree
```

Now we can see who locks it:

```
pipdeptree -r -p urllib3

urllib3==1.23
  - botocore==1.11.1 [requires: urllib3>=1.20,<1.24]
    - boto3==1.8.1 [requires: botocore>=1.11.1,<1.12.0]
    - s3transfer==0.1.10 [requires: botocore>=1.3.0,<2.0.0]
      - boto3==1.8.1 [requires: s3transfer>=0.1.10,<0.2.0]
  - elasticsearch==2.4.1 [requires: urllib3>=1.8,<2.0]
  - requests==2.20.1 [requires: urllib3>=1.21.1,<1.25]
    - braintree==3.34.0 [requires: requests>=0.11.1,<3.0]
      - django-payments==0.13.0 [requires: braintree>=3.14.0]
    - django-payments==0.13.0 [requires: requests>=1.2.0]
    - easypost==3.6.3 [requires: requests>=1.0.0six]
    - google-i18n-address==2.0.1 [requires: requests>=2.7.0]
    - google-measurement-protocol==0.1.6 [requires:
      requests>=2.0,<3.0a0]
    - lob==3.1.2 [requires: requests]
    - optimizely-sdk==1.1.1 [requires: requests>=2.9.1]
    - premailer==3.0.1 [requires: requests]
      - django-emailit==0.2.2 [requires: premailer>=1.12]
    - requests-mock==1.5.2 [requires: requests>=1.1]
    - requests-oauthlib==0.7.0 [requires: requests>=2.0.0]
      - social-auth-core==1.2.0 [requires: requests-oauthlib>=0.6.1]
        - social-auth-app-django==1.1.0 [requires:
          social-auth-core>=1.2.0]
    - social-auth-core==1.2.0 [requires: requests>=2.9.1]
      - social-auth-app-django==1.1.0 [requires:
        social-auth-core>=1.2.0]
    - stripe==2.6.0 [requires: requests>=2]
      - django-payments==0.13.0 [requires: stripe>=2.6.0]
    - taxjar==1.3.0 [requires: requests>=2.13.0]
```

In this case, it's `botocore` is locking urllib3 at `<1.24`
