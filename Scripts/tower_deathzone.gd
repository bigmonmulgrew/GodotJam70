extends Area2D

## A script that causes the player to fall from the tower and respawn.
##
## This script uses an on_body_exited method to detect when the player leaves the tower. For now, it then drains the player's health by 50% of their max health, and creates a timer after which the player will respawn. Respawn logic is not yet implemented.

## Variable used to store health_component of the body that exits the area.
var health_component
## Export variable used to set the respawn time
@export var respawn_time: float = 3
## variable used to later reference the created respawn_timer
var respawn_timer: Timer = null
@onready var game_manager = $"/root/GameManager"

## Method that receives the body_exited signal. It reduces the player's health by 50% of their max health total.
func _on_body_exited(body):
	health_component = body.get_node("HealthComponent")
	if health_component:
		health_component.remove_health((health_component.max_health * 0.5)) # damage type defaults to physical
		game_manager.respawn_character()
