extends Node2D
class_name BaseProjectile

@export var travel_speed: float = 10
@export var damage_value: int = 10
@export var damage_type: DamageType.Type
@export var impact_explosion: bool = false
# @export var 
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

func deal_damage():
	pass

func delete_projectile():
	queue_free()

func explode():
		print(str(name) + " EXPLODED!!")
