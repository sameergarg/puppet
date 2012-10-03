# declares stages necessary to control execution order of classes
class runstages{
	stage{"prepare":
	}
	stage{"initialise":
	}
	stage{"pre":
	}
	stage{"post":
	}
	stage{"final":
	}
	
	Stage["initialise"]->Stage["pre"]->Stage["main"]->Stage["post"]->Stage["final"]
}