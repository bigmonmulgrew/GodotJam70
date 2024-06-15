extends Node


## Movement speed as a float
@export var speed: float = 10
## Max movement speed as a float
@export var max_speed: float = 500

var parent_to_move: CharacterBody2D
var _can_move: bool = true

func _ready():
	parent_to_move = get_parent()

func _physics_process(delta):
	var horizontal = Input.get_axis("move_left","move_right")
	var vertical = Input.get_axis("move_up", "move_down")
	
	# Check if the parent is not null
	if parent_to_move:
		if _can_move:
			if horizontal == 0:
				parent_to_move.velocity.x = 0
			if vertical == 0:
				parent_to_move.velocity.y = 0
			# Add horizontal velocity and keep it in bounds
			parent_to_move.velocity.x += horizontal * speed
			parent_to_move.velocity.x = clamp(parent_to_move.velocity.x, -max_speed, max_speed)
			
			parent_to_move.velocity.y += vertical * speed
			parent_to_move.velocity.y = clamp(parent_to_move.velocity.y, -max_speed, max_speed)
			
			#print(parent_to_move.velocity)
		
	else:
		print("Parent not found for movement component")


func set_can_move(flag: bool) -> void:
	_can_move = flag
