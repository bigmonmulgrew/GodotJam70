extends StaticBody2D

@export var damage_amount: int = 2
@export var bounce_force: float = 1000
@onready var health_component

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print(body.name)
	health_component = body.get_node("HealthComponent")
	health_component.remove_health(damage_amount)
	var direction = body.velocity.normalized()
	if direction == Vector2.ZERO:
		direction = global_position - body.global_position
		direction = direction.normalized()
	print(direction)
	
	body.velocity = -direction * bounce_force
