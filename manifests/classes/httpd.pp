class httpd {
  package { httpd:
    ensure => latest
  }

  file { "/etc/httpd/conf/httpd.conf":
    source => "/etc/puppet/manifests/files/httpd/httpd.conf",
    mode => 644,
    require => Package["httpd"]
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
                   Package["httpd"] ]
  }
}