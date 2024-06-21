extends Attack

@onready var raycast = $RayCast2D

func use():
	fire()
	
func fire():
	raycast.enabled = true
	raycast.line.visible = true

func stop_firing():
	raycast.enabled = false
	raycast.line.visible = false
