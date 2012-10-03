class sqldeveloper($username) {
	notify {"-----------Installing Oracle SQLDeveloper -----------------":}
	
	file { "/root/.sqldeveloper":
		ensure => directory,
		owner => root,
		group => "$groupname",
		mode  => 666,
	}
	
	file { "/home/$username/.sqldeveloper":
		ensure => directory,
		owner => "$username",
		group => "$groupname",
		mode  => 666,
	}
	
	file { "/root/.sqldeveloper/jdk":
		ensure => present,
		owner => root,
		group => "$groupname",
		mode  => 666,
		content => "$sunjavahome" ,
		require => File["/root/.sqldeveloper"],
	}
	
	file { "/home/$username/.sqldeveloper/jdk":
		ensure => present,
		owner => "$username",
		group => "$groupname",
		mode  => 666,
		content => "$sunjavahome" ,
		require => File["/home/$username/.sqldeveloper"],
	}

	exec { "installing sql developer":
		unless => 'test -f "/usr/local/bin/sqldeveloper"',
		command => "rpm -Uhv $installsbasepath/oracle/sqldeveloper-3.0.04.34-1.noarch.rpm",
		require => File["/home/$username/.sqldeveloper/jdk"],
	}
}