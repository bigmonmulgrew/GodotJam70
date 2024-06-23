extends Attack

class_name ThrownAttack

## An attack component for a Thrown Attack.
##
## Thrown attack is a component that can be attached to a player or an enemy to allow them to use a ThrownAttack.

## Var that can be changed in editor for a sound file that can be played
@export var sound_ref: AudioStream


## The cooldown of the ThrownAttack
@export var thrown_attack_cooldown: float = 2
## A variable used to store the parent node
var parent_component: CharacterBody2D
## A variable used to store a health component of the parent node
var health_component: Node
## A variable used to store a reference to an empty node container, under which Thrown attacks are instanced.
var thrown_attack_container: Node
## A preload of the fireball scene so that it can be instanced.
@export var thrown_attack_scene = preload("res://Scenes/Components/Actions/Attacks/Ranged/thrown_attack.tscn")

## The ready method attaches the parent_component, the health_component, and the thrown_attack_container to the appropriate nodes.
func _ready():
	parent_component = owner
	print("PARENT COMPONENT NAME: " + str(parent_component.name))
	health_component = owner.get_node("HealthComponent")
	

## Implementation of the use() method from the action_base class. When called, it calls the fire method to use the thrown attack.
func use():
	fire()

## The fire method instances a Thrown attack, adds it to the thrown_attack_container node, gets the direction in which the parent is facing, and sends the Thrown attack out in that direction.
##[br]
##[br]
## It uses the cooldown implementation from the base_action class.a
func fire():
	if not can_use:
		return
	can_use = false
	start_cooldown_timer()
	print("Creating fireball")
	

	##Play the audio SFX
	AudioManager.play_sfx(sound_ref,1,-30)
	
	var thrown_attack_instance = thrown_attack_scene.instantiate()
	get_tree().get_root().add_child(thrown_attack_instance)
	var direction = Vector2(cos(parent_component.rotation), sin(parent_component.rotation))
	thrown_attack_instance.projectile_direction = direction
	thrown_attack_instance.global_position = get_parent().global_position
	thrown_attack_instance.global_rotation = parent_component.global_rotation
	
