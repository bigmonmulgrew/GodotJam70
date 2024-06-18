extends Attack

@export var fireball_cooldown: float = 2
var parent_component: CharacterBody2D
var health_component: Node
var fireball_container: Node

var fireball_scene = preload("res://Scenes/fireball.tscn")

func _ready():
	parent_component = owner
	print("PARENT COMPONENT NAME: " + str(parent_component.name))
	health_component = owner.get_node("HealthComponent")
	fireball_container = owner.get_node("ProjectileContainer")

func use():
	fire()

func fire():
	if not can_use:
		return
	can_use = false
	var fireball_instance = fireball_scene.instantiate()
	fireball_container.add_child(fireball_instance)
	var direction = Vector2(cos(parent_component.rotation), sin(parent_component.rotation))
	fireball_instance.projectile_direction = direction
	fireball_instance.global_position = global_position
	start_cooldown_timer()
