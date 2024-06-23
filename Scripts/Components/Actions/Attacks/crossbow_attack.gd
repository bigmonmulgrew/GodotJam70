extends Attack

class_name CrossbowBolterAttack

## An attack component for firing a crossbowbolt.
##
## crossbowbolt attack is a component that can be attached to a player or an enemy to allow them to fire a crossbow bolt.

## The cooldown of the crossbow bolt
@export var crossbowbolt_cooldown: float = 0.5
## A variable used to store the parent node
var parent_component: CharacterBody2D
## A variable used to store a health component of the parent node
var health_component: Node
## A variable used to store a reference to an empty node container, under which Crossbow bolts are instanced.
var crossbowbolt_container: Node
## A preload of the Crossbow bolt scene so that it can be instanced.
@export var crossbowbolt_scene = preload("res://Scenes/Components/Actions/Attacks/Ranged/crossbow_bolt.tscn")

## The ready method attaches the parent_component, the health_component, and the crossbowbolt_container to the appropriate nodes.
func _ready():
	parent_component = owner
	print("PARENT COMPONENT NAME: " + str(parent_component.name))
	health_component = owner.get_node("HealthComponent")
	

## Implementation of the use() method from the action_base class. When called, it calls the fire method to send out a Crossbow bolt.
func use():
	fire()

## The fire method instances a crossbowbolt, adds it to the crossbowbolt_container node, gets the direction in which the parent is facing, and sends the crossbowbolt out in that direction.
##[br]
##[br]
## It uses the cooldown implementation from the base_action class.a
func fire():
	if not can_use:
		return
	can_use = false
	start_cooldown_timer()
	print("Creating crossbowbolt")
	var crossbowbolt_instance = crossbowbolt_scene.instantiate()
	get_tree().get_root().add_child(crossbowbolt_instance)
	var direction = Vector2(cos(parent_component.rotation), sin(parent_component.rotation))
	crossbowbolt_instance.projectile_direction = direction
	crossbowbolt_instance.global_position = get_parent().global_position
