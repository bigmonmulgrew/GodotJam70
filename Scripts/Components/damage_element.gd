extends Area2D
class_name DamageElement

@export var timer_time: float = 0.5
@export var damage_amount: int = 2
@onready var timer_instance = $Timer
@onready var health_component
@onready var bCanDamageBody: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_instance.start(timer_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## Finds the health component of the body that overlaps (can be player or enemy depending on setup, but default is player) and then sets it as damageable.
##[br]
##[br]
##Damage is dealt in Timeout method.
func _on_body_entered(body):
	health_component = body.get_node("HealthComponent")
	bCanDamageBody = true

func _on_body_exited(body):
	health_component = null
	bCanDamageBody = false

func _on_timer_timeout():
	if bCanDamageBody == true:
		health_component.remove_health(damage_amount)



