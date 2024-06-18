extends Attack

var parent_component: CharacterBody2D
var health_component: Node
var fireball_container: Node
var can_fire = true

var fireball_scene = preload("res://Scenes/fireball.tscn")

func _ready():
	parent_component = owner
	health_component = owner.get_node("HealthComponent")
	fireball_container = owner.get_node("ProjectileContainer")

func use():
	fire()

func fire():
	if not can_fire:
		return
	var fireball_instance = fireball_scene.instantiate()
	fireball_container.add_child(fireball_instance)
	fireball_instance.projectile_direction = (get_global_mouse_position() - owner.global_position).normalized()
	fireball_instance.global_position = global_position
	print("Fireball fired in the direction vector" + str(fireball_instance.projectile_direction))
