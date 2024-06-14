extends Node

@onready var i_frame_timer: Timer = $IFramesTimer

## Current health value as an integer
@export var health: int  = 0
## Max health value as an integer
@export var max_health: int = 100
## Timer for immunity in seconds as a float
@export var immunity_timer_value: float = 1.0

var is_immune: bool =  false



func add_health(amount: int) -> void:
	health += amount
	# Check and reset health if it goes over max
	if health > max_health:
		health = max_health

func remove_health(amount: int) -> void:
	if not is_immune:
		health -= amount
		i_frame_timer.start(immunity_timer_value)
		is_immune = true

func _on_i_frames_timer_timeout():
	is_immune = false
