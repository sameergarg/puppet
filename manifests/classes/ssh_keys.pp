class ssh_keys($username)  {

	file { "/home/$username/.ssh":
	    ensure => directory,
		owner => "$username",
		group => "$groupname",
		mode => 600	
	}

	file { "/home/$username/.ssh/authorized_keys":
		ensure => file,
		owner => "$username",
		group => "$groupname",
		mode => 600,
		source => [
		"/etc/puppet/manifests/files/ssh/authorized_keys",
		],		
	}
}