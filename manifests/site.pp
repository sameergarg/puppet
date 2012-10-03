# /etc/puppet/manifests/site.pp

import "classes/*"
import "classes/rackspace-cloud/*"

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

$groupname = "dev"
$installsbasepath = "/development/downloads/installs"
$sunjavahome = "/development/tools/jdk1.6.0_24"
$ibmjavahome = "/development/tools/ibm-java2-x86_64-50"
$washome = "/development/server/ibm/was/6.1"
$ibm = "/development/server/ibm"

node 'default' {
    include runstages
	group { "puppet": 
    	ensure => "present", 
	}
    class {init: stage => prepare,}
    class {svncheckoutcron: stage => initialise,}
    
    include sudoers
}

node 'jl-internal' inherits 'default' {
	$jl_internal = true
}

node "jprakash-dev-centos" inherits 'default' {
	$developer1 = "cogjagprakash"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "torija-dev" inherits 'default'{
	$developer1 = "torija"
	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}	
	class {jrebel: username => "$developer1", stage => post,}	
	# class {m2settings: username => "$developer1", stage => main,}
}

node "rnorth-dev-centos" inherits 'default' {
	$developer1 = "rnorth"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "nsheppard-dev-centos" inherits 'jl-internal' {
	$developer1 = "neilsheppard"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "sameergarg-dev-centos" inherits 'default' {
	$developer1 = "sameergarg"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "sameer-dev-centos" inherits 'default' {
	$developer1 = "sameer"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}

	class {jrebel: username => "$developer1", stage => post,}
}



node "irfan-centos" inherits 'default' {
	$developer1 = "irfan"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	class {firefox: username => "$developer1" }

	class {jrebel: username => "$developer1", stage => post,}
}

node "mbannister-dev-centos" inherits 'jl-internal' {
	$developer1 = "mbannister"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "mbannister-dev-suse" inherits 'default' {
	$developer1 = "mbannister"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "tsmith-dev-centos" inherits 'default' {
	$developer1 = "tsmith"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "rwalrond-dev-centos" inherits 'default' {
	$developer1 = "rwalrond"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "ruppal-dev-centos" inherits 'default' {
	$developer1 = "ruppal"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "dadams-dev-centos" inherits 'default' {
	$developer1 = "dadams"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "rkent-dev-centos" inherits 'default' {
	$developer1 = "rkent"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "aclark-dev-centos" inherits 'default' {
	$developer1 = "aclark"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "mologan-dev" inherits 'default' {
	$developer1 = "mologan"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "subhash-dev" inherits 'default' {
	$developer1 = "subhash"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "kamran" inherits 'default' {
	$developer1 = "kamran"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "maspeli-dev" inherits 'default' {
	$developer1 = "optilude"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "dhaval-dev" inherits 'default' {
	$developer1 = "dhaval"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "jess-dev" inherits 'default' {
	$developer1 = "jess"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "ptoler-atgproto" inherits 'default' {
	$developer1 = "ptoler"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}

}

node "mahsubramanian-dev-centos" inherits 'default' {
	$developer1 = "mahsubramanian"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}

}
node "chweeks-dev" inherits 'default' {
	$developer1 = "chweeks"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "stmccoy-dev" inherits 'default' {
	$developer1 = "stmccoy"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "johynds-dev" inherits 'default' {
	$developer1 = "johynds"

	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {sqldeveloper: username => "$developer1", stage =>main,}
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {sts: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	
	class {jrebel: username => "$developer1", stage => post,}
}

node "webpim-ci-base" inherits 'rackspace-cloud' {
	$developer1 = "webpim-ci"
	
	class {users: username => "$developer1", stage => pre, }
	class {jdk: username => "$developer1", stage => pre,}
	include oracle
	class {websphere-extractor: username => "$developer1", stage =>main,}
	class {maven: stage => main,}
	class {profile: stage=>final,}
	class {permissions: stage=>final,}
	class {generic-webpim-config: username => "$developer1", stage =>main}
	class {ssh_keys: username => "$developer1" }
	
	class {firefox-new: username => "$developer1" }
	
	include hudson-slave-iptables
}

node "webpim-ci-slave" inherits 'webpim-ci-base' {
	class {m2settings: username => "$developer1"}
	
}

node "webpim-ci-skinny" inherits 'webpim-ci-slave' {
	include network_hosts
}

node "webpim-ci-sleepy" inherits 'webpim-ci-slave' {
	include network_hosts
}

node "webpim-ci-dopey" inherits 'webpim-ci-slave' {
	include network_hosts
}

node "webpim-ci-funky" inherits 'webpim-ci-slave' {
	include network_hosts
}

node "webpim-ci-happy" inherits 'webpim-ci-slave' {
	include network_hosts
}

node "webpim-2012-ci-mickey" inherits 'webpim-ci-slave' {
	include network_hosts
}

node "webpim-2012-ci-minnie" inherits 'webpim-ci-slave' {
	include network_hosts
}

node "webpim-2012-ci-pluto" inherits 'webpim-ci-slave' {
	include network_hosts
}

node "webpim-2012-ci-goofy" inherits 'webpim-ci-slave' {
	include network_hosts
}

node "webpim-fat1" inherits 'webpim-ci-slave' {
	include httpd
}

node "webpim-2012-fat1" inherits 'webpim-ci-slave' {
	include httpd
}

node "webpim-uat1" inherits 'webpim-ci-slave' {
	include httpd
}

node "jenkins-master" inherits 'rackspace-cloud' {
	yumrepo { "Jenkins-Redhat":
		baseurl => "http://pkg.hudson-labs.org/redhat/",
		descr   => "Jenkins Redhat repository",
		enabled => 0,
		gpgcheck=> 0,
	}
	
	yumrepo { "Jenkins-LTS-Redhat":
		baseurl  => "http://pkg.jenkins-ci.org/redhat-stable/",
		descr    => "Jenkins LTS Redhat repository",
		enabled  => 1,
		gpgcheck => 1,
		gpgkey   => "http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key",
	}
	
	package { "jenkins":
		ensure  => latest,
		require => [ Yumrepo["Jenkins-LTS-Redhat"] ]
	}
	
	package { "java-1.6.0-openjdk-devel":
		ensure  => absent,
	}
	
	package { "liberation-fonts":
		ensure => installed
	}
	
	class {jdk: username => "jenkins-admin", stage => pre,}
	
	class {users: username => "jenkins-admin", stage => pre, }
	class {ssh_keys: username => "jenkins-admin" }
	
	iptables { "Allow HTTP (8080) from Deloitte IP Address range":
	  	proto       => "tcp",
	  	dport       => "8080",     
	  	source      => "170.194.32.0/24",
	  	jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTP (80) from Deloitte IP Address range":
	  	proto       => "tcp",
	  	dport       => "80",     
	  	source      => "170.194.32.0/24",
	  	jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTPS (443) from Deloitte IP Address range":
	  	proto       => "tcp",
	  	dport       => "443",     
	  	source      => "170.194.32.0/24",
	  	jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTPS (443) from John Lewis IP Address range":
	  	proto       => "tcp",
	  	dport       => "443",     
	  	source      => "193.35.249.130/16",
	  	jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTP (8080) from John Lewis IP Address range":
	  	proto       => "tcp",
	  	dport       => "8080",     
	  	source      => "193.35.249.130/16",
	  	jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTP (80) from John Lewis IP Address range":
	  	proto       => "tcp",
	  	dport       => "80",     
	  	source      => "193.35.249.130/16",
	  	jump        => "ACCEPT",
	}
	
	iptables { "Allow SSH from App2 (Hudson master) IP Address":
	  proto       => "tcp",
	  dport       => "22",
	  source      => "212.64.133.157/32",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow SSH from John Lewis IP Address range":
	  proto       => "tcp",
	  dport       => "22",
	  source      => "193.35.249.130/16",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTPS from App2 (Hudson master) IP Address":
	  proto       => "tcp",
	  dport       => "443",
	  source      => "212.64.133.157/32",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTPS from Mahesh home IP Address":
	  proto       => "tcp",
	  dport       => "443",
	  source      => "82.40.189.79",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTPS from Michael home IP Address":
	  proto       => "tcp",
	  dport       => "443",
	  source      => "188.222.8.225",
	  jump        => "ACCEPT",
	}

	service { jenkins:
    	ensure => running,
		require => Package["jenkins"]
	}	
	
	include httpd-ssl
}
