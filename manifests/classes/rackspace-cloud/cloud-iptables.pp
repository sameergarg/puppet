class cloud-iptables {
	notify {"-----------Configuring IPTables -----------------":}
	
	iptables { "Allow SSH from Deloitte IP Range":
	  proto       => "tcp",
	  dport       => "22",
	  source      => "170.194.32.0/24",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow Oracle SQL from Deloitte IP Range":
	  proto       => "tcp",
	  dport       => "1521",
	  source      => "170.194.32.0/24",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow any outbound traffic":
	  chain       => "OUTPUT",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow any local traffic":
	  iniface     => "lo",
	  jump        => "ACCEPT",
	}
	
	iptables { "Allow incoming responses on established connections":
	  state       => ["ESTABLISHED","RELATED"],
	  jump        => "ACCEPT",
	}
	
	iptables { "Reject any other incoming traffic":
	  jump        => "DROP",
	}
	
	file { "/etc/puppet/iptables":
	  ensure  => "directory",
	  mode    => 0600,
	}
	
	file { "/etc/puppet/iptables/pre.iptables":
	  ensure  => "present",
	  content => "",
	  mode    => 0600,
	}
	file { "/etc/puppet/iptables/post.iptables":
	  ensure  => "present",
	  content => "",
	  mode    => 0600,
	}
}