+++
date = "2019-02-07T15:02:15-08:00"
title = "tls cert tips"
draft = false
hidden = false

tags = ["devops", "tls", "ssl"]
+++

When working with TLS cert, I need to check thing like what domain this
cert is for, when is this cert going to expire. Or I have setup the cert
in standby server, how I can hit it up myself locally to ensure it's
valid?

### Check expired day of a cert on server

Before I put this server to public, I want to make sure its cert is
right:

```
echo | openssl s_client -servername [domain-name] -connect 127.0.0.1:443 2>/dev/null | openssl x509 -noout -dates
```

### Check that web server has right cert

```
echo | openssl s_client -servername [domain-name] -connect 127.0.0.1:443 2>/dev/null | openssl x509 -noout -issuer -subject -dates
```

Those command works to check the cert being served by web server, if we
have a `crt` or `pem` file what do we do.

All above command of `openssl` receive input from `stdin`. The cert that
those command operate on are fetch dynamically by `openssl s_client`. We
can explicitly pass `pem` file as its input:

```
openssl x509 -enddate -noout -in file.pem
openssl x509 -noout -issuer -subject -dates -in file.pem
```

References:

- [https://www.shellhacks.com/openssl-check-ssl-certificate-expiration-date/
](https://www.shellhacks.com/openssl-check-ssl-certificate-expiration-date/)
- [https://stackoverflow.com/questions/21297853/how-to-determine-ssl-cert-expiration-date-from-a-pem-encoded-certificate](https://stackoverflow.com/questions/21297853/how-to-determine-ssl-cert-expiration-date-from-a-pem-encoded-certificate)
