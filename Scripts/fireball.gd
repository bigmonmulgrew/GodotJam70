extends BaseProjectile

var collided_body: CharacterBody2D
var health_component
var fireball_container: Node

var flames_scene = preload("res://Scenes/Components/damage_element.tscn")
@onready var level_root = get_tree().current_scene

func _ready():
	print("Parent node = " + str(get_parent().name))

func _on_fireball_area_body_entered(body):
	health_component = body.get_node("HealthComponent")
	if health_component:
		health_component.remove_health(damage_value, damage_type)
		delete_projectile()
	if impact_explosion:
		explode()

func explode():
	super()
	var flames_instance = flames_scene.instantiate()
	print("FLAMES")
	level_root.add_child(flames_instance)
	flames_instance.global_position = global_position
	flames_instance.scale = Vector2(0.2, 0.2)
	delete_projectile()
	# NEED TO SET DESPAWN TIME AND BOOLEAN ONCE THE RELEVANT BRANCH IS MERGED WITH MAIN
