extends Node


## Movement acceleration as a float
@export var acceleration: float = 1200
## Movement deceleration as a float
@export var deceleration: float = 1600
## Max movement speed as a float
@export var speed: float = 200.0

var parent_to_move: CharacterBody2D
var _can_move: bool = true
var horizontal
var vertical

func _ready():
	parent_to_move = get_parent()

func _physics_process(delta):
	if not parent_to_move:
		print("Parent not found for movement component")
		return
	_apply_user_input(delta)
func set_can_move(flag: bool) -> void:
	_can_move = flag

func _apply_user_input(delta) -> void:
	horizontal = Input.get_axis("move_left","move_right")
	vertical = Input.get_axis("move_up", "move_down")
	
	# Check if the parent is not null
	if _can_move:
		#acceleration and deceleration interp mode setting for the move toward function
		var celMoveSpeed = acceleration
		if horizontal == 0 and vertical == 0:
			celMoveSpeed = deceleration
		parent_to_move.velocity = parent_to_move.velocity.move_toward(Vector2(speed*horizontal,speed*vertical),celMoveSpeed*delta)
		
		#print(parent_to_move.velocity)
