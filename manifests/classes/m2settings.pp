
class m2settings($username) {
	
	file { "/home/$username/.m2":
	    ensure => directory,
		owner => "$username",
		group => "$groupname",
		mode => 644	
	}
	
	file { "/home/$username/.m2/settings.xml":
		ensure => file,
		owner => "$username",
		group => "$groupname",
		mode => 644,
		source => [
		"/etc/puppet/manifests/files/settings.xml",
		],		
	}
	
}