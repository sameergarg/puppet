class httpd-ssl       {
  package { httpd:
    ensure => latest
  }

  package { mod_ssl:
    ensure => latest
  }

  file { "/etc/httpd/conf/httpd.conf":
    source => "/etc/puppet/manifests/files/httpd/httpd-jenkins.conf",
    mode => 644,
    require => Package["httpd"]
  }
  
  file { "/etc/httpd/conf.d/ssl.conf":
    source => "/etc/puppet/manifests/files/httpd/ssl.conf",
    mode => 644,
    require => [ Package["httpd"], Package["mod_ssl"] ]
  }

  group { apache: gid => 48 }

  user { apache: 
   comment => "Apache",
   uid => 48,
   gid => 48,
   home => "/var/www",
   shell => "/sbin/nologin"
  }

  service { httpd:
    ensure => running,
    subscribe => [ File["/etc/httpd/conf/httpd.conf"],
    			   File["/etc/httpd/conf.d/ssl.conf"],
                   Package["httpd"] ]
  }
}