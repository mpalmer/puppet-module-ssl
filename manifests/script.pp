class ssl::script {
	file { "/usr/local/bin/generate-self-signed-certificate":
		ensure => "file",
		owner  => "root",
		group  => "root",
		mode   => "0555",
		source => "puppet:///modules/ssl/generate-self-signed-certificate",
	}
}
