extends Attack

class_name FireballAttack

## An attack component for firing a fireball.
##
## Fireball attack is a component that can be attached to a player or an enemy to allow them to fire a fireball.

## The cooldown of the fireball
@export var fireball_cooldown: float = 2
## A variable used to store the parent node
var parent_component: CharacterBody2D
## A variable used to store a health component of the parent node
var health_component: Node
## A variable used to store a reference to an empty node container, under which fireballs are instanced.
var fireball_container: Node
## A preload of the fireball scene so that it can be instanced.
@export var projectile_scene = preload("res://Scenes/Components/Actions/Attacks/Magic/fireball_projectile.tscn")

## The ready method attaches the parent_component, the health_component, and the fireball_container to the appropriate nodes.
func _ready():
	parent_component = owner
	print("PARENT COMPONENT NAME: " + str(parent_component.name))
	health_component = owner.get_node("HealthComponent")
	

## Implementation of the use() method from the action_base class. When called, it calls the fire method to send out a fireball.
func use():
	fire()

## The fire method instances a fireball, adds it to the fireball_container node, gets the direction in which the parent is facing, and sends the fireball out in that direction.
##[br]
##[br]
## It uses the cooldown implementation from the base_action class.a
func fire():
	if not can_use:
		return
	can_use = false
	start_cooldown_timer()
	print("Creating fireball")
	var fireball_instance = projectile_scene.instantiate()
	get_tree().get_root().add_child(fireball_instance)
	var direction = Vector2(cos(parent_component.rotation), sin(parent_component.rotation))
	fireball_instance.projectile_direction = direction
	fireball_instance.global_position = get_parent().global_position
	
