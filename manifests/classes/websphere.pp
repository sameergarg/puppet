# install scripts for setting up upgraded websphere application server v 6.1 with latest updates

class websphere {
	
	file {"$washome":
		ensure => directory,
		group => "$groupname"
	}
	
	file {"$installsbasepath/websphere/6.1/WAS/install":
		ensure => present,
		owner => root,
		group => "$groupname",
		mode => 774,
		require => File["$washome"],
	}
	
	file {"$installsbasepath/websphere/6.1/response-was.txt":
		ensure => present,
		owner => root,
		group => "$groupname",
		mode => 664,
		require => File["$installsbasepath/websphere/6.1/WAS/install"],
	}
	
	file {"$installsbasepath/websphere/6.1/response-was-update.txt":
		ensure => present,
		owner => root,
		group => "$groupname",
		mode => 664,
		require => File["$installsbasepath/websphere/6.1/WAS/install"],
	}
	exec {"replacing the text to obtain OS version number since its position is changed in cent os 5.5":
		command => 'sed -i "s/print $7}/print $3}/" /development/downloads/installs/websphere/updates/installer/install',
	}
	exec { 'installing was 6.1 in silent mode':
		path => ["/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ,"$ibmjavahome/bin"],		
		unless => "/usr/bin/test -d $washome/bin/",
		command => "rm -rf $washome; $installsbasepath/websphere/6.1/WAS/install -silent -options $installsbasepath/websphere/6.1/response-was.txt",
		timeout => 0,
		require => File["$installsbasepath/websphere/6.1/response-was.txt"],
	}
	

	exec { 'updating was 6.1 update silent mode':
		path => ["/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ,"$ibmjavahome/bin"],		
		unless => "/usr/bin/test -d $washome/update/",
		command => "$installsbasepath/websphere/updates/installer/install -silent -options $installsbasepath/websphere/updates/installer/response-was-update.txt",
		timeout => 0,
		require => File["$installsbasepath/websphere/6.1/response-was-update.txt"],
	}
	
	exec {'copy fix pack files':
		command => "cp -u $installsbasepath/websphere/6.1.0.31fixpack/*.pak $washome/update/maintenance",
		unless => "/usr/bin/test -f $washome/update/6.1.0-WS-WAS-LinuxX64-FP0000031.pak",
	}
	
	exec { 'upgrading was 6.1 in silent mode':
		path => ["/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ,"$ibmjavahome/bin"],		
		unless => "/usr/bin/test -f $washome/update/maintenance/6.1.0-WS-WAS-LinuxX64-FP0000031.pak",
		command => "$washome/update/update.sh -silent -options $installsbasepath/websphere/6.1.0.31fixpack/response-was-upgrade.txt",
		timeout => 0,
		require => Exec["copy fix pack files"],
	}
	
	exec { 'copying oracle jdbc driver to lib directory of was home':
		command => "cp $installsbasepath/oracle/driver/ojdbc5.jar $washome/lib/",
	}
	
	
	Exec ["replacing the text to obtain OS version number since its position is changed in cent os 5.5"]
	-> Exec['installing was 6.1 in silent mode']
	-> Exec['updating was 6.1 update silent mode']
	-> Exec['copy fix pack files']
	-> Exec['upgrading was 6.1 in silent mode']
	-> Exec['copying oracle jdbc driver to lib directory of was home']
	
	

}