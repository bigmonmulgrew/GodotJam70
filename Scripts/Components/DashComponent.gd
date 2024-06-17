extends Node

## Dash speed as a float
@export var dash_amount: float = 900;
## Dash immunity time as a float
@export var immune_time: float = 0.1
## Dash cooldown time in seconds as a float
@export var dash_cooldown: float = 2

var health_component: Node
var parent_component: CharacterBody2D
var movement_component: Node
var cooldown_timer: Timer
var dash_timer: Timer
var can_dash = true
var is_dashing = false

func _ready():
	parent_component = owner
	health_component = owner.get_node("HealthComponent")
	movement_component = owner.get_node("UserMovementComponent")
	cooldown_timer = $DashCooldownTimer
	dash_timer = $DashTimer

func use():
	_dash()


func _dash() -> void:
	if not can_dash:
		return
	print("dashed")
	# Exit out if no movement component is found
	if not movement_component:
		print("Movement component not found, cannot dash")
		return
	# Exit out if the parent component isn't found
	if not parent_component:
		print("Parent not found for dash component")
		return
	# If the health component exists, add immunity time
	if health_component:
		# Start the i frames on the health component
		health_component.add_immunity(immune_time)
	else:
		print("Health component not found. Dashing with no immunity")
	
	
	
	is_dashing = true
	# Start the timer for how long you will be dashing
	dash_timer.start(immune_time)
	
	
	# Stop the player from moving
	movement_component.set_can_move(false)
	var dash_direction = Vector2(movement_component.horizontal, movement_component.vertical)
	parent_component.velocity = dash_direction.normalized() * dash_amount
		
		
	# No more dashing ;-;
	can_dash = false
	cooldown_timer.start(dash_cooldown)



func _on_dash_cooldown_timer_timeout():
	can_dash = true


func _on_dash_timer_timeout():
	is_dashing = false
	movement_component.set_can_move(true)
