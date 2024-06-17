extends Node2D
class_name BaseProjectile

@export var travel_speed: float = 10
var projectile_active: bool = true
var projectile_position: Vector2
var projectile_direction: Vector2

func _ready():
	pass
	
func _process(delta):
	pass
	
func _physics_process(delta):
	update_position(delta)
	
func update_position(delta):
	if projectile_active:
		projectile_position += projectile_direction * travel_speed
