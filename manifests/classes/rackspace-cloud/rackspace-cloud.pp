

node "rackspace-cloud" inherits 'default' {
	include cloud-iptables
	
  package { zip:
    ensure => latest
  }
}

