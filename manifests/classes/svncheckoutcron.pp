# /etc/puppet/manifests/classes/cron.pp

class svncheckoutcron {    
    
    cron{'apply latest puppet classes after hour starting at 00 minutes':
    	command => "svn checkout --force --username webpim-build --password y0nPhsG --non-interactive https://projectepic.jira.com/svn/PIM/trunk/infrastructure/puppet /etc/puppet",
    	ensure => present,
    	user => root,
    	hour => '*',
	    minute => '00',
    }
    
}