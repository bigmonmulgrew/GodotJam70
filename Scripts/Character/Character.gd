extends CharacterBody2D

@export var health: int = 10


func ready():
	$HealthComponent.max_health = health

func _physics_process(delta):
	look_at(get_global_mouse_position())
	move_and_slide()
	
