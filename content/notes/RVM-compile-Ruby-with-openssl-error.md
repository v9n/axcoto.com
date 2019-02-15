+++
date = "2019-02-15T12:36:41-08:00"
title = "RVM compile Ruby with openssl error"
draft = true

tags = ["rvm", "ruby", "hack"]
+++

When you encounter these kind of error:

```
8 warnings and 1 error generated.
ossl_x509crl.c:175:5: warning: implicit declaration of function 'X509_CRL_get0_signature' is invalid in C99 [-Wimplicit-function-declaration]
    X509_CRL_get0_signature(crl, NULL, &alg);
    ^
ossl_x509crl.c:214:12: warning: implicit declaration of function 'X509_CRL_get0_lastUpdate' is invalid in C99 [-Wimplicit-function-declaration]
    time = X509_CRL_get0_lastUpdate(crl);
           ^
ossl_x509crl.c:214:10: warning: incompatible integer to pointer conversion assigning to 'const ASN1_TIME *' (aka 'const struct asn1_string_st *') from 'int' [-Wint-conversion]
    time = X509_CRL_get0_lastUpdate(crl);
         ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ossl_x509crl.c:229:10: warning: implicit declaration of function 'X509_CRL_set1_lastUpdate' is invalid in C99 [-Wimplicit-function-declaration]
    if (!X509_CRL_set1_lastUpdate(crl, asn1time)) {
         ^
ossl_x509crl.c:245:12: warning: implicit declaration of function 'X509_CRL_get0_nextUpdate' is invalid in C99 [-Wimplicit-function-declaration]
    time = X509_CRL_get0_nextUpdate(crl);
           ^
ossl_x509crl.c:245:10: warning: incompatible integer to pointer conversion assigning to 'const ASN1_TIME *' (aka 'const struct asn1_string_st *') from 'int' [-Wint-conversion]
    time = X509_CRL_get0_nextUpdate(crl);
         ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ossl_x509crl.c:260:10: warning: implicit declaration of function 'X509_CRL_set1_nextUpdate' is invalid in C99 [-Wimplicit-function-declaration]
    if (!X509_CRL_set1_nextUpdate(crl, asn1time)) {
         ^
make[2]: *** [ossl_x509cert.o] Error 1
make[2]: *** Waiting for unfinished jobs....
ossl_x509req.c:266:5: warning: implicit declaration of function 'X509_REQ_get0_signature' is invalid in C99 [-Wimplicit-function-declaration]
    X509_REQ_get0_signature(req, NULL, &alg);
    ^
ossl_x509revoked.c:134:31: warning: implicit declaration of function 'X509_REVOKED_get0_serialNumber' is invalid in C99 [-Wimplicit-function-declaration]
    return asn1integer_to_num(X509_REVOKED_get0_serialNumber(rev));
                              ^
ossl_x509revoked.c:134:31: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'const ASN1_INTEGER *' (aka 'const struct asn1_string_st *') [-Wint-conversion]
    return asn1integer_to_num(X509_REVOKED_get0_serialNumber(rev));
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./ossl_asn1.h:31:46: note: passing argument to parameter here
VALUE asn1integer_to_num(const ASN1_INTEGER *);
                                             ^
ossl_x509revoked.c:161:12: warning: implicit declaration of function 'X509_REVOKED_get0_revocationDate' is invalid in C99 [-Wimplicit-function-declaration]
    time = X509_REVOKED_get0_revocationDate(rev);
           ^
ossl_x509revoked.c:161:10: warning: incompatible integer to pointer conversion assigning to 'const ASN1_TIME *' (aka 'const struct asn1_string_st *') from 'int' [-Wint-conversion]
    time = X509_REVOKED_get0_revocationDate(rev);
         ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
7 warnings generated.
4 warnings generated.
7 warnings generated.
1 warning generated.
make[1]: *** [ext/openssl/all] Error 2
make[1]: *** Waiting for unfinished jobs....
linking shared-object ripper.bundle
make: *** [build-ext] Error 2
```

It's more likely cause by some old openssl lib ship with default Mac.
Nowsaday everyone use `brew` so it can be fixed with:

```
rvm install ruby 2.6.1 --with-openssl-dir=`brew --prefix openssl`
```

The `--with-open-ssl-dir` configured rvm to use homebrew openssl version
