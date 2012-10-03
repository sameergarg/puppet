class generic-webpim-config($username) {
    file { "/home/$username/webpim-config.properties":
        owner => $username,
        group => $groupname,
        mode => 660
    }
}
