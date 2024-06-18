extends Area2D
class_name DamageElement

## A damage area.
## 
## DamageElement is an area that damages the player as they walk through it. When they leave the area, the player stops taking damage.
## [br]
## This would be used to represent an acid pool, or an AoE attack such as flames in the arena.
## [br]
## [br]
## For solid damage elements that the player cannot walk through, find StaticDamageElement.
## [br]
## [br]
## This interacts with the player by receiving collision bodies and acting upon their HealthComponent node.

## A float that represents the amount of time before the timer Timeout signal fires.
@export var timer_time: float = 0.5
## The amount of damage dealt each time the on_timer_timeout method is called.
@export var damage_amount: int = 2
## Set the damage type
@export var damage_type: DamageType.Type = DamageType.Type.PHYSICAL
## Gets a reference to the Timer node from the DamageElement object.
@onready var damage_timer_instance = $Timer
## A boolean that says whether the trap will despawn after a specified amount of time.
@export var despawn_boolean = false
## A float that specifies the time until the trap should despawn.
@export var despawn_time = 0
## An empty variable that can be used to hold the health component of the received collision body.
@onready var health_component
## A boolean that allows the DamageElement to hurt the player while they are in the area of effect.
@onready var bCanDamageBody: bool = false

## This simply starts the Timer. Since bCanDamageBody defaults to false, each Timeout will have no effect until something enters the area of effect.
##[br]
## If despawn_boolean has been set to true in the editor, then this trap will automatically delete itself after the specified despawn time.
func _ready():
	damage_timer_instance.start(timer_time)
	if despawn_boolean:
		await get_tree().create_timer(despawn_time).timeout
		queue_free()

## Finds the health component of the body that overlaps (can be player or enemy depending on setup, but default is player) and then sets it as damageable.
##[br]
##[br]
##Damage is dealt in Timeout method.
func _on_body_entered(body):
	health_component = body.get_node("HealthComponent")
	bCanDamageBody = true

## Removes the health component, resetting it to null. Sets bCanDamageBody to false, so that damage is no longer dealt.
func _on_body_exited(body):
	health_component = null
	bCanDamageBody = false

## When the damage_timer's Timeout signal fires, if the received collision body is damageable, health equal to the damage amount will be removed from its current health.
func _on_timer_timeout():
	if bCanDamageBody == true:
		health_component.remove_health(damage_amount, damage_type)
