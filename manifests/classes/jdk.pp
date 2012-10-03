# install sun jdk and ibm jdk

class jdk($username) {	
	
	file {"/development/tools/jdk1.6.0_24":
		ensure => directory,
		owner => "$username",
	}
	
	file {"/development/tools/ibm-java2-x86_64-50":
		ensure => directory,
		owner => "$username",
	}
	
	exec { 'install sun jdk 1.6.0_24':
		unless => 'test -d "/development/tools/jdk1.6.0_24/bin"',
		command => "tar -xvzf $installsbasepath/java/jdk1.6.0_24.tar.gz -C /development/tools/; export JAVA_HOME=/development/tools/jdk1.6.0_24",
	}
	
	exec { 'install ibm jdk':
		unless => 'test -d "/development/tools/ibm-java2-x86_64-50/bin"',
		command => "tar -xvzf $installsbasepath/java/ibm-java2-sdk-5.0-12.4-linux-x86_64.tgz -C /development/tools/",
	}
	
	exec { 'set default java':
		command => "ln -sf /development/tools/jdk1.6.0_24/bin/java /usr/bin/java",
		require => Exec['install sun jdk 1.6.0_24'],
	}
	
}