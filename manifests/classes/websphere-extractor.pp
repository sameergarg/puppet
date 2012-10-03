class websphere-extractor($username) {
	
	$nodeconfig = "/development/server/ibm/was/6.1/profiles/AppSrv01/config/cells/basewebpim-devNode01Cell/nodes/basewebpim-devNode01"
	
	$filepath = "/etc/puppet/manifests/files/websphere"
	# use this when testing locally before committing!
	# $filepath = "/home/mbannister/workspace/webpim/infrastructure/puppet/manifests/files/websphere"
	
	exec{"Extracting was 6.1.0.31 Fixpack 39 installation":
		command => "rm -rf $ibm/was; tar -xzf $installsbasepath/websphere/was-6.1.0.31-fp39-complete-pack.tar.gz -C $ibm/",
		unless => "/usr/bin/test -f $washome/FEP_staging/6.1.0.39-WS-WASWebSvc-EP0000039.pak",
	}
	
	exec{"Correcting privileges for was installation":
		command => "chmod -R 776 was; chgrp -R $groupname $washome; chown -R $username $washome",
	}
	
	exec{"Removing aspectj runtime jar file":
		command => "rm -f $washome/lib/aspectjrt.jar",
	}
	
	exec{"Executing script to fix serverindex.xml":
		command => "sed --in-place -e 's/hostName=\"basewebpim-dev\\.local\"/hostName=\"$hostname.local\"/' -e 's/basewebpim-dev\\.local/$hostname/' $washome/profiles/AppSrv01/config/cells/basewebpim-devNode01Cell/nodes/basewebpim-devNode01/serverindex.xml",
	}
	
	file{"wsadmin properties":
		path => "$washome/profiles/AppSrv01/properties/soap.client.props",
		source => "$filepath/soap.client.props",
		mode => 644,
		owner => $username,
	}
	
	exec{"Fixing keystore 1":
		command => "cp $filepath/{key.p12,trust.p12,ltpa.jceks} $nodeconfig/",
	}
	
	exec{"Starting websphere if not already running":
		command => "su $username -c \"$washome/bin/startServer.sh server1 \"; echo Started ", 
	}
	
	exec{"Fixing keystore 2":
		command => "$washome/bin/retrieveSigners.sh NodeDefaultTrustStore ClientDefaultTrustStore -user admin -password admin -autoAcceptBootstrapSigner",
	}
	
	exec{"Executing script for cleaning up SIB tables managed by WAS":
		command => "rm -rf $washome/profiles/AppSrv01/filestores/com.ibm.ws.sib",
	}
	
	exec{"Executing script for setting up WebSphere JVM settings":
		command => "$washome/bin/wsadmin.sh -lang jython -username admin -password admin -f $filepath/jvm_config.py",
	}
	
	exec{"Executing script for setting up JMS queues":
		command => "$washome/bin/wsadmin.sh -lang jython -username admin -password admin -f $filepath/jms_config.py",
		tries => 2,
		timeout => 400,
	}
	
	exec{"Executing script for setting up JDBC datasource":
		command => "$washome/bin/wsadmin.sh -lang jython -username admin -password admin -f $filepath/jdbc_config.py",
	}
	
	exec{"Executing script for setting up DMS JDBC datasource":
		command => "$washome/bin/wsadmin.sh -lang jython -username admin -password admin -f $filepath/dms_jdbc_config.py",
	}
	
	if $jl_internal == true {
		exec{"Executing script for setting up JL Test JDBC datasource":
			command => "$washome/bin/wsadmin.sh -lang jython -username admin -password admin -f $filepath/jl_test_jdbc_config.py",
			require => Exec["Executing script for setting up JDBC datasource"],
			before => Exec["Restarting websphere and cleaning up pending transations"]
		}
	}
	
	exec{"Executing script for setting up system environment variable for external property files for web application":
		command => "$washome/bin/wsadmin.sh -lang jython -username admin -password admin -f $filepath/app_config.py",
	}
	
	exec{"Restarting websphere and cleaning up pending transations":
		command => "su $username -c \"$washome/bin/stopServer.sh server1 -user admin -password admin\" ; rm -rf $washome/profiles/AppSrv01/tranlog/basewebpim-devNode01Cell/basewebpim-devNode01/server1/transaction/tranlog;rm -rf $washome/profiles/AppSrv01/tranlog/basewebpim-devNode01Cell/basewebpim-devNode01/server1/transaction/partnerlog; su $username -c \"$washome/bin/startServer.sh server1 \"; echo Started",
	}
	
	Exec["Extracting was 6.1.0.31 Fixpack 39 installation"]
	-> Exec["Correcting privileges for was installation"]
	-> Exec["Removing aspectj runtime jar file"]
	-> File["wsadmin properties"]
	-> Exec["Executing script to fix serverindex.xml"]
	-> Exec["Fixing keystore 1"]
	-> Exec["Starting websphere if not already running"]
	-> Exec["Fixing keystore 2"]
	-> Exec["Executing script for cleaning up SIB tables managed by WAS"]
	-> Exec["Executing script for setting up WebSphere JVM settings"]
	-> Exec["Executing script for setting up JMS queues"]
	-> Exec["Executing script for setting up JDBC datasource"]
	-> Exec["Executing script for setting up DMS JDBC datasource"]
	-> Exec["Executing script for setting up system environment variable for external property files for web application"]
	-> Exec["Restarting websphere and cleaning up pending transations"]
}
