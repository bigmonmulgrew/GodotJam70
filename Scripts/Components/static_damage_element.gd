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
## Array of currently colliding bodies / node2Ds.
var colliding_objects:Array[Node2D]

## Adds newly collided bodies to the colliding_objects Array for later processing.
func _on_body_entered(body: Node2D):
	colliding_objects.push_back(body)
## Removes any bodies the leave collision area from the colliding_objects Array.
func _on_body_exit(body:Node2D):
	colliding_objects.remove_at(colliding_objects.find(body,0))
	
## Processes all the colliding bodies in colliding_objects.
##[br]
##[br]
## Going through each of the objects and calculate their collisons using a shapecast from their previous position to there next position with veloicty.
##[br]
##[br]
## Requires a disabled SHAPECAST2D Node.
func _process(delta):
	for body in colliding_objects:
		print(body.name)
		#Calculate the bodies collision shape if it has it
		var ShapeRef:CollisionShape2D = body.get_node("CollisionShape2D")
		#Set the shapecasts casting shape based on the "ShapeRef" if it exists
		if ShapeRef != null:
			$ShapeCast2D.shape = ShapeRef.shape
		#Set shape cast to the bodies previous position
		$ShapeCast2D.global_position = body.global_position-(body.velocity*get_physics_process_delta_time())
		#Set the shapes relative target cast position to be where the player is
		$ShapeCast2D.target_position = (body.velocity*get_physics_process_delta_time())
		#Update the cast recalculating it
		$ShapeCast2D.force_shapecast_update()
		if $ShapeCast2D.get_collision_count()>0:
			#Health malipulation
			health_component = body.get_node("HealthComponent")
			health_component.remove_health(damage_amount, damage_type)
			#Direction to throw object
			var direction = $ShapeCast2D.get_collision_normal(0)
			direction = direction.normalized()
			#Add velocity to the body
			body.velocity = direction * bounce_force
