class hudson-slave-iptables {
	notify {"-----------Configuring IPTables for Hudson Slave -----------------":}
	
	iptables { "Allow SSH from App2 (Hudson master) IP Address":
	  proto       => "tcp",
	  dport       => "22",
	  source      => "212.64.133.157/32",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTPS from App2 (Hudson master) IP Address":
	  proto       => "tcp",
	  dport       => "443",
	  source      => "212.64.133.157/32",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow SSH from John Lewis IP Address range":
	  proto       => "tcp",
	  dport       => "22",
	  source      => "193.35.249.130/24",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow SSH from jenkins-master IP Address":
	  proto       => "tcp",
	  dport       => "22",
	  source      => "46.38.187.240/32",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow Websphere HTTP from Deloitte IP Address range":
	  proto       => "tcp",
	  dport       => "9080",  
	  source      => "170.194.32.0/24",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTP from Deloitte IP Address range":
	  proto       => "tcp",
	  dport       => "80",     /* Should be port forwarded to 9080 */
	  source      => "170.194.32.0/24",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow Websphere Admin HTTP from Deloitte IP Address range":
	  proto       => "tcp",
	  dport       => "9043",
	  source      => "170.194.32.0/24",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTP from John Lewis IP Address range (wifi)":
	  proto       => "tcp",
	  dport       => "80",		/* Should be port forwarded to 9080 */
	  source      => "193.35.249.130/24",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow HTTP from John Lewis IP Address range (LAN)":
	  proto       => "tcp",
	  dport       => "80",		/* Should be port forwarded to 9080 */
	  source      => "193.35.248.120/24",
	  jump        => "ACCEPT",
	}
	
}