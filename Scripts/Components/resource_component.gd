extends Node

## The max amount of the resource as an integer
@export var resource_cap: int = 100

@export_group("Regeneration")
## The amount of time it takes in seconds to regen some resource as a float
@export var regen_time: float = .5
## The amount of resource you get back when the regen timer expires as an integer
@export var amount_to_regen: int = 1

@export var current_resource = 50
@onready var regen_timer: Timer = $RegenTimer


func add_resource(amount: int) -> void:
	current_resource += amount
	# Stops going over cap
	if current_resource > resource_cap: current_resource = resource_cap
	

# returns true if the amount can be spent
func spend_resource(amount: int) -> bool:
	if current_resource - amount < 0:
		return false
	else:
		current_resource -= amount
		return true


func _on_regen_timer_timeout():
	add_resource(amount_to_regen)
	if regen_time > 0: regen_timer.start(regen_time)
