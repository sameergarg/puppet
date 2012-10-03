# set up configured version of STS

class sts {	
	
	file {'/development/tools/ide':
		ensure => directory,
		group => "$groupname",
	}
	
	exec {'setup spring tools suite if not present already':
		command => "tar -zvxf $installsbasepath/tools/STS/springsource.tar.gz; mv springsource /development/tools/ide/",
		unless  => "test -d /development/tools/ide/springsource", 
	}
	
}