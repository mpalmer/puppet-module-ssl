Management of SSL certificates and all such miscellany.

If you say:

    ssl::certificate { "www.example.com": }

You can be 100% sure that there will be an 2048 bit RSA key and a
certificate available in the relevant location for your OS.  This may be a
self-signed certificate and a CSR to request a real certificate, but there
will at least be *something* for you to play with.
