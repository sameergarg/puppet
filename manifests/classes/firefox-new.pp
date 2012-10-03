class firefox-new($username) {
	notify {"-----------Installing Firefox -----------------":}
	
	package { "firefox": 
		ensure => "present", 
		require => Package["xulrunner"] 
	}
	
	package { xulrunner:
	    ensure => "present"
	}
	
	package { tigervnc-server:
		ensure => latest
	}
	
}