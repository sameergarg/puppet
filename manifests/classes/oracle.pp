class oracle() {
	notify {"-----------Installing Oracle 11g XE -----------------":}
	
	package { libaio:
		ensure => latest
	}
	
	package { libaio-devel:
		ensure => latest
	}
	
	package { bc:
		ensure => latest
	}
	
	file { "$installsbasepath/oracle/response-configure-oracle-XE":
		ensure => present,
		owner => root,
		group => "$groupname",
		mode  => 666,
	}
	
		
	# return 0 when oracle is not installed
	exec {"installing and configuring oracle xe in silent mode":
		unless => 'test -e "/etc/init.d/oracle-xe"',
		command => "rpm -ivh  $installsbasepath/oracle/oracle-xe-11.2.0-0.5.x86_64.rpm > /development/xesilentinstall.log; 
					export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;
					export ORACLE_SID=xe;
					export ORACLE=/u01/app/oracle/product/11.2.0/xe;
					/etc/init.d/oracle-xe configure < $installsbasepath/oracle/response-configure-oracle-XE >> /development/xesilentinstall.log",
		require => File["$installsbasepath/oracle/response-configure-oracle-XE"]		
	}
	
	exec {"Configuring Oracle DB user":
		require => Exec['installing and configuring oracle xe in silent mode'],
		command => "echo 'Executing oracle user-create script';
					export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;
					export ORACLE=/u01/app/oracle/product/11.2.0/xe;
					cat /etc/puppet/manifests/files/create_webpim_db_user.sql | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus SYSTEM/password@xe",
	}
	
	exec {"Configuring DMS Oracle DB user":
		require => Exec['installing and configuring oracle xe in silent mode'],
		command => "echo 'Executing oracle dms user-create script';
					export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;
					export ORACLE=/u01/app/oracle/product/11.2.0/xe;
					cat /etc/puppet/manifests/files/create_dms_db_user.sql | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus SYSTEM/password@xe",
	}
	
	Exec ["installing and configuring oracle xe in silent mode"]
	-> Exec['Configuring Oracle DB user']
}