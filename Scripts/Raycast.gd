extends RayCast2D
@onready var line = $Line2D
@onready var particle_emitter = $GPUParticles2D

var health_component
var movement_component
var parent_node

func _ready():
	line.visible = false
	parent_node = get_parent()

func _physics_process(delta):
	if not enabled:
		particle_emitter.emitting = false
		return

	line.set_point_position(0, Vector2(0,0))
	line.set_point_position(1, Vector2(500,0))
	line.visible = true
	force_raycast_update()  # Ensure the raycast is updated

	if not is_colliding():
		particle_emitter.emitting = false
		return

	var collider = get_collider()
	if collider is PhysicsBody2D or collider.get_parent() is PhysicsBody2D:  # Check if the collided object is a physics body
		particle_emitter.emitting = true
		var collision_point_local = line.to_local(get_collision_point())
		var collision_point_global = get_collision_point()
		particle_emitter.position = collision_point_local
		line.set_point_position(1, collision_point_local)
		
		# finding the health component and dealing damage to it
		health_component = collider.get_node("HealthComponent")
		if health_component != null and parent_node.b_can_damage:
			health_component.remove_health(parent_node.damage)
		
		# finding the movement component and moving it by the required force
		if not collider is StaticBody2D and ("Walls" not in collider.get_groups()) and parent_node.b_has_force:
			var player_position = get_tree().get_nodes_in_group("players")[0].global_position
			var direction_player_to_body = player_position.direction_to(collision_point_global)
			collider.global_position = collider.global_position + (direction_player_to_body * parent_node.force)
