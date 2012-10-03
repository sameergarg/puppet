class network_hosts{
	
	exec{"Routing s7 server to localhost":
		command => "chmod +x /etc/puppet/manifests/files/network/update-hosts.sh; /etc/puppet/manifests/files/network/update-hosts.sh",
	}
	
}