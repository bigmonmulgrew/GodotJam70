extends StaticBody2D
class_name StaticDamageElement

## A solid element that deals damage.
##
## StaticDamageElement is a solid object trap that deals damage to the received collision body. It cannot be moved through. For an area of effect damage trap that the player and enemies can pass through, look for DamageElement.
##[br]
##[br]
## This has a knockback effect on received collision bodies, bouncing them away after dealing damage.

## The amount of damage dealt by the trap.
@export var damage_amount: int = 2
## The force with which the trap bounces away the received collision body.
@export var bounce_force: float = 1000
## Damage type to apply.
@export var damage_type: DamageType.Type = DamageType.Type.PHYSICAL
## An empty variable to store the recieved collision body's health component.
@onready var health_component

## Receives a collision body and gets it's health component. It then deals damage to the body, before bouncing it away with a knockback effect.
##[br]
##[br]
## The knockback effect works by first getting the direction of the received collision body by normalising it's velocity.
##[br]
## It then checks if the direction is a ZERO vector (0,0). If it is, StaticDamageElement instead gets it's direction by finding the different between it's own position and the received body's position.
##[br]
## Finally, it flips the direction and applies the bounce_force to knock the received collision body away.
func _on_body_entered(body):
	print(body.name)
	health_component = body.get_node("HealthComponent")
	health_component.remove_health(damage_amount, damage_type)
	var direction = body.velocity.normalized()
	if direction == Vector2.ZERO:
		direction = global_position - body.global_position
		direction = direction.normalized()
	print(direction)
	
	body.velocity = -direction * bounce_force
