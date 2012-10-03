class firefox($username) {
	notify {"-----------Installing Firefox -----------------":}
	
	package { "firefox-3.6.26-1.el5.centos.x86_64": ensure => "present", require => Package["xulrunner"] }
	
	package { xulrunner:
		name => "xulrunner-1.9.2.26-1.el5_7.x86_64",
	    ensure => "present"
	}
	
	package { vnc-server:
		ensure => latest
	}
	
#	file { "/home/$username/.vnc":
#		ensure => directory,
#		owner => "$username",
#		group => "$groupname",
#		mode => 755,
#	}
	
#	file { "/home/$username/.vnc/passwd":
#		ensure => file,
#		content => "ÛØ<ýrz^TX
#",
#		owner => "$username",
#		group => "$groupname",
#		mode => 755,
#	}

}