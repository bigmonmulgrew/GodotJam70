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
	parent_component = get_parent()
	health_component = get_node("../HealthComponent")
	movement_component = get_node("../UserMovementComponent")
	cooldown_timer = $DashCooldownTimer
	dash_timer = $DashTimer

func _process(delta):
	if Input.is_action_just_pressed("defensive_action"): 
		if can_dash:
			_dash()


func _dash() -> void:
	print("dashed")
	if health_component:
		if parent_component:
			is_dashing = true
			dash_timer.start(immune_time)
			#var prev_max_vel = movement_component.max_speed
			#movement_component.max_speed = 100000
			health_component.add_immunity(immune_time)
			movement_component.set_can_move(false)
			parent_component.velocity = parent_component.velocity.normalized() * dash_amount
			#movement_component.max_speed = prev_max_vel
			
			# No more dashing ;-;
			can_dash = false
			cooldown_timer.start(dash_cooldown)
		else:
			print("Parent not found for dash component")
	else:
		print("Health component not found")


func _on_dash_cooldown_timer_timeout():
	can_dash = true


func _on_dash_timer_timeout():
	is_dashing = false
	movement_component.set_can_move(true)
