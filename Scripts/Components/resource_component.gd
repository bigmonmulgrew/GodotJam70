extends Node

## The max amount of the resource as an integer
@export var resource_cap: int = 100

var current_resource = 50

func add_resource(amount: int) -> void:
	current_resource += amount
	# Stops going over cap
	if current_resource > resource_cap: current_resource = resource_cap
	

# returns true if the amount can be spent
func spend_resource(amount: int) -> bool:
	if current_resource - amount < 0:
		return false
	else:
		current_resource - amount
		return true
