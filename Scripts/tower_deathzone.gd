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

## This starts a timer with a respawn time equal to that set in the inspector using the respawn_time export variable. It first creates a timer if there is no timer to start.
func start_respawn_timer(time: float = respawn_time) -> void:
	# Check if timer is null and create first.
	if respawn_timer == null: create_timer()
	
	# Start the timer
	respawn_timer.start(time)

## This is where we will call/implement the respawn logic for the player later.
func _on_respawn_timer_timeout() -> void:
	print("I HAVE RESPAWNED")
	#b_is_active = true

## Creates a timer that, when it times out, sends a signal to the _on_respawn_timer_timeout method.
func create_timer():
	# Make a timer
	respawn_timer = Timer.new()
	# Add as a child
	add_child(respawn_timer)
	# Connnect the signal to renable can_use
	respawn_timer.timeout.connect(_on_respawn_timer_timeout)
	# Stop the timer from looping
	respawn_timer.one_shot = true

## Method that receives the body_exited signal. It reduces the player's health by 50% of their max health total.
func _on_body_exited(body):
	health_component = body.get_node("HealthComponent")
	if health_component:
		health_component.remove_health((health_component.max_health * 0.5)) # damage type defaults to physical
		start_respawn_timer(respawn_time)
