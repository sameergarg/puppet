# initialises the paths, ownership and variables

class init {
	notify {"-----------Executing initialisation-----------------":}
	yumrepo {"epel":
		baseurl => "http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-3.noarch.rpm",
		enabled => 0,
	}
	
	exec {"Setting enforce to false":
		command => "/usr/sbin/setenforce 0 ; echo 'assume OK'",
	}
	
	file { "/development":
        owner => "root",
        group => "$groupname",
        mode  => 774,
    }
    
    exec {"Changing permissions for downloads directory":
		command => "chmod -R +x /development/downloads",
	}
	
	file {"/development/tools":
		ensure => directory,
		group  => "$groupname",		
	}
	
	file {"/development/server":
		ensure => directory,
		group  => "$groupname",		
	}
	
	file {"/development/server/ibm":
		ensure => directory,
		group  => "$groupname",
	}
	
	file {"/development/server/ibm/was":
		ensure => directory,
		group  => "$groupname",
	}
	
	file {"/etc/webpim":
		ensure => directory,
		mode => 666,
	}
	
	file {"/etc/dms":
		ensure => directory,
		mode => 666,
	}
	
	group {"developer group":
		ensure   => present,
		name     => "$groupname",
		members  => root,
		allowdupe => "false", 
	}
	
	package { subversion:
        ensure => latest,
    }
    
    package { "compat-libstdc++-33.x86_64":
    	ensure => latest,
    }
} 