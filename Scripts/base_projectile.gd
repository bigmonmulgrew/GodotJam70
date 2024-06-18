extends Node2D
class_name BaseProjectile

@export var travel_speed: float = 10
@export var damage_value: int = 10
@export var impact_explosion: bool = false
var projectile_active: bool = true
var projectile_position: Vector2
var projectile_direction: Vector2

func _ready():
	pass
	
func _physics_process(delta):
	update_position(delta)
	
func update_position(delta):
	if projectile_active:
		global_position += projectile_direction * travel_speed

func explode():
		print(str(name) + " EXPLODED!!")
		var flames_instance = StaticDamageElement.instantiate()
		fireball_container.add_child(flames_instance)
		fireball_instance.global_position = global_position
		queue_free()
