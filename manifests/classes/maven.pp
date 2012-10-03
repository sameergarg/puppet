# installs latest version of maven

class maven {
	
	file { '/development/tools/maven/':
		ensure => directory,
		owner => root,
		group => "$groupname",
		mode => 664,
	}
	
	
	exec { 'Installing maven 3 if not present already':
		unless => 'test -d "/development/tools/maven/apache-maven-3.0.3/bin"',
		command => "tar -zvxf $installsbasepath/tools/maven/apache-maven-3.0.3-bin.tar.gz; mv apache-maven-3.0.3 /development/tools/maven/",
	}
	
	# used for maven javadoc generation - Graphviz
	
	yumrepo { "graphviz":
      baseurl => "http://www.graphviz.org/pub/graphviz/stable/redhat/el5/$architecture/os/",
      descr => "Graphviz Stable",
      enabled => 1,
      gpgcheck => 0
   }
  
	package { graphviz:
		ensure => latest,
		require => Yumrepo["graphviz"]
	}
	
}