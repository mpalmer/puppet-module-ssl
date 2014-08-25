# Ensure that a certificate (and key) is available for the given name.
#
# Attributes:
#
#  * `name` (*namevar*; required)
#
#     The common name of the certificate you wish to ensure exists.
#
define ssl::certificate() {
	exec {
		"create key for ${name}":
			command => "/usr/bin/openssl genrsa -out /etc/ssl/private/${name}.pem 2048",
			creates => "/etc/ssl/private/${name}.pem";
		"create CSR for ${name}":
			command => "/usr/bin/openssl req -new -key /etc/ssl/private/${name}.pem -subj /CN=${name}/ -out /etc/ssl/${name}.csr",
			creates => "/etc/ssl/${name}.csr",
			unless  => "/usr/bin/test -e /etc/ssl/certs/${name}.pem",
			require => Exec["create key for ${name}"];
		"create self-signed certificate for ${name}":
			command => "/usr/bin/openssl x509 -req -days 36500 -in /etc/ssl/${name}.csr -signkey /etc/ssl/private/${name}.pem -out /etc/ssl/certs/${name}.pem",
			require => Exec["create CSR for ${name}"],
			creates => "/etc/ssl/certs/${name}.pem";
	}
}
	
