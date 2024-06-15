extends CharacterBody2D


func _physics_process(delta):
	look_at(get_global_mouse_position())
	move_and_slide()
