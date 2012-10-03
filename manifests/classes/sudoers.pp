class sudoers {
    file { "/etc/sudoers":
        owner => root,
        group => root,
        mode => 440,
        source => "/etc/puppet/manifests/files/sudoers"
    }
}
