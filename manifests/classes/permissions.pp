class permissions {
	
	exec {"Changing permissions for development directory":
		command => "chmod -R 776 /development; chgrp -R $groupname /development",
	}
	
}