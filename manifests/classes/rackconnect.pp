class rackconnect {
	exec {"Configuring RackConnect":
		# only run if the /etc/rackconnect.v*.COMPLETE file does not exist
		unless => 'test -e /etc/rackconnect.v1.COMPLETE',
		
		cwd     => "/etc/puppet/manifests/files/rackspace",
		command => "chmod +x *.sh;
		            ./rshybridnetworkconfig.sh;
		            touch /etc/rackconnect.v1.COMPLETE"
	}
}