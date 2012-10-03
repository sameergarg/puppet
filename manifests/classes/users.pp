# creates various users

class users($username) {

	file { 'creating user home directory':
		ensure => directory,
		mode => 755,
		owner => "$username",
		group => "$groupname",
		path => "/home/$username",
		require => User['creating user for the system'],
	}
	
	user {'creating user for the system':
		ensure => present,
		gid => root,
		groups => [dev],
		home => "/home/$username",
		shell => '/bin/bash',
		managehome => true,
		system => true,
		password => 'password',
		name => "$username",
	}
	
}
