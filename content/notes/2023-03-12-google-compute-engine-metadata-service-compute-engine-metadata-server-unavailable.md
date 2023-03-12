+++
date = "2023-03-12T14:34:36-07:00"
title = "Google Compute Engine metadata service. Compute Engine Metadata server unavailable"
draft = false

tags = ['devops', 'gcp', 'auth', 'adc']
+++

I had a note where if you run a SQL query directly from the host using
`bq` client, using service account authentication then it works.

However, when run from a Python shell, using google bigquery SDK inside
a docker container, I got this error:

```
google.auth.exceptions.RefreshError: Failed to retrieve http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/?recursive=true from the Google Compute Engine metadata service. Compute Engine Metadata server unavailable
```

This error is more common on GKE when failed to assign a service account
to the deployment. But in my case, I can reach the node the metadata
service directly when running with `bq` client. I can even curl this.

Turning out there are a DNS issue somehow `/etc/resolve.conf` inside the
container to `1.1.1.1`, which break .internal domain resolver.

So I updated `/etc/resolv.conf` to

```
nameserver 127.0.0.53
options edns0
search google.internal
```

then restart the docker daemon and after that everything works again.