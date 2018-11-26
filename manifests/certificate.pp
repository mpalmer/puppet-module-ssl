# Ensure that a certificate (and key) is available for the given name.
#
# Attributes:
#
#  * `title` (*namevar*; required)
#
#     The common name of the certificate you wish to ensure exists.
#
define ssl::certificate($destdir = "/etc/ssl") {
	include ssl::script

	exec {
		"create self-signed certificate for ${title}":
			command => "/usr/local/bin/generate-self-signed-certificate ${title}",
			environment => {
				"DESTDIR" => $destdir,
			},
			creates => "${destdir}/certs/${title}.pem",
	}
}
