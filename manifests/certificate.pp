# Ensure that a certificate (and key) is available for the given name.
#
# Attributes:
#
#  * `name` (*namevar*; required)
#
#     The common name of the certificate you wish to ensure exists.
#
define ssl::certificate($destdir = "/etc/ssl") {
	exec {
		"create key for ${name}":
			command => "/usr/bin/openssl genrsa -out ${destdir}/private/${name}.pem 2048",
			creates => "${destdir}/private/${name}.pem";
		"create CSR for ${name}":
			command => "/usr/bin/openssl req -new -key ${destdir}/private/${name}.pem -subj /CN=${name}/ -out ${destdir}/${name}.csr",
			creates => "${destdir}/${name}.csr",
			unless  => "/usr/bin/test -e ${destdir}/certs/${name}.pem",
			require => Exec["create key for ${name}"];
		"create self-signed certificate for ${name}":
			command => "/usr/bin/openssl x509 -req -days 36500 -in ${destdir}/${name}.csr -signkey ${destdir}/private/${name}.pem -out ${destdir}/certs/${name}.pem",
			require => Exec["create CSR for ${name}"],
			creates => "${destdir}/certs/${name}.pem";
	}
}
