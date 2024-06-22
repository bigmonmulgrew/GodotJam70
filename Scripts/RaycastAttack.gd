extends Attack

@onready var raycast = $RayCast2D
@export var b_can_damage: bool = true
@export var b_has_force: bool = false
@export var force: float = 0

func use():
	fire()
	
func fire():
	raycast.enabled = true
	raycast.line.visible = true

func stop_firing():
	raycast.enabled = false
	raycast.line.visible = false
