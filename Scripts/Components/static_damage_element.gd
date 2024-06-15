extends RigidBody2D

@export var damage_amount: int = 2
@onready var health_component

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print(str(body))
	health_component = body.get_node("HealthComponent")
	health_component.remove_health(damage_amount)
	var direction = body.velocity.normalized()
	print(str(direction * -1))
	if direction.x != 0:
		direction.x *= -1
		body.velocity.x += 1000 * direction.x
	if direction.y != 0:
		direction.y *= -1
		body.velocity.y += 1000 * direction.y
