# install JRebel (not linked to WebSphere)

class jrebel($username) {	
	
	file {"/development/tools/jrebel":
		ensure => directory,
		owner => "$username",
	}
	
	exec { 'install jrebel':
		unless => 'test -d "/development/tools/jrebel/jrebel-bootstrap.jar"',
		command => "tar -C /development/tools/ -xvzf $installsbasepath/tools/jrebel/jrebel.tar.gz",
	}
	
	exec { 'Create JRebel bootstrap.jar for Websphere JDK':
		command => "/bin/sh -c 'export JAVA_HOME=/development/server/ibm/was/6.1/java; cd /development/tools/jrebel; /development/server/ibm/was/6.1/java/bin/java -jar jrebel.jar'"
	}
	
	Exec["install jrebel"]
	-> Exec["Create JRebel bootstrap.jar for Websphere JDK"]
}