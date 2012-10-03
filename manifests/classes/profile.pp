class profile {
	file { "/etc/profile.d/developer.profile.sh":
		owner => root,
		group => "$groupname",
		mode => 775,
		source => [
		"/etc/puppet/manifests/files/developer.profile.sh",
		],		
	}
}