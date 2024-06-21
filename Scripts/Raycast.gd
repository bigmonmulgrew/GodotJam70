extends RayCast2D
@onready var line = $Line2D
@onready var particle_emitter = $GPUParticles2D

@export var b_can_damage: bool = true
@export var force: float = 0

func _ready():
	line.visible = false

func _physics_process(delta):
	if enabled == true:
		print("Laser beam is firing!")
		line.visible = true
		force_raycast_update()  # Ensure the raycast is updated
		particle_emitter.emitting = false
		if is_colliding():
			var collider = get_collider()
			if collider is PhysicsBody2D:  # Check if the collided object is a physics body
				print("I am colliding with a body!")
				particle_emitter.emitting = true

## Check if the collider has a health component
## if yes, check if ray set to damage, if yes, remove health
## Check if collider has movement component
## if yes, check if force > 0 or force < 0
## if force < 0, pull, if force > 0, push
