extends Attack


var parent_component: CharacterBody2D
var health_component: Node
var can_fire = true

var fireball_scene = preload("res://Scenes/fireball.tscn")

func _ready():
	parent_component = owner
	health_component = owner.get_node("HealthComponent")

func use():
	fire()

func fire():
	if not can_fire:
		return
	var fireball_instance = fireball_scene.instantiate()
	fireball_instance.projectile_direction = get_parent().rotation
	fireball_instance.global_position = global_position
	fireball_instance.global_position.x += 50
