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
@export var bounce_force: float = 200
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
func _on_body_entered(body: Node2D):
	print(body.name)
	health_component = body.get_node("HealthComponent")
	health_component.remove_health(damage_amount, damage_type)
	#dogde but quick fix for knock back to work better for all shapes
	var ShapeRef:CollisionShape2D = body.get_node("CollisionShape2D")
	if ShapeRef != null:
		$ShapeCast2D.shape = ShapeRef.shape
	$ShapeCast2D.global_position = body.global_position-(body.velocity*get_physics_process_delta_time())
	$ShapeCast2D.target_position = (body.velocity*get_physics_process_delta_time())
	$ShapeCast2D.clear_exceptions()
	$ShapeCast2D.add_exception(body)
	$ShapeCast2D.force_shapecast_update()
	var direction = $ShapeCast2D.get_collision_normal(0)
	direction = direction.normalized()
  
	print(direction," DT " , get_physics_process_delta_time())
	
	body.velocity = direction * bounce_force
