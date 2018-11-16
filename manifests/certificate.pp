# Ensure that a certificate (and key) is available for the given name.
#
# Attributes:
#
#  * `title` (*namevar*; required)
#
#     The common name of the certificate you wish to ensure exists.
#
define ssl::certificate($destdir = "/etc/ssl") {
	exec {
		"create self-signed certificate for ${title}":
			command => "/usr/bin/openssl req -x509 -newkey rsa:2048 -nodes -keyout ${destdir}/private/${title}.pem -subj /CN=${title}/ -out ${destdir}/certs/${title}.pem -days 3650",
			creates => "${destdir}/private/${title}.pem",
			unless  => "/usr/bin/test -e ${destdir}/certs/${title}.pem";
	}
}
