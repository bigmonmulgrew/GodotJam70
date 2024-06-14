extends Node

@export var parent_to_move: CharacterBody2D
## Movement speed as a float
@export var speed: float = 10

func _physics_process(delta):
	var horizontal = Input.get_axis("move_left","move_right")
	var vertical = Input.get_axis("move_up", "move_down")
	
	if parent_to_move:
		parent_to_move.velocity.x = horizontal * speed
		parent_to_move.velocity.y = vertical * speed
	else:
		print("Parent not found for movement component")
