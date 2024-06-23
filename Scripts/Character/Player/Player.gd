extends CharacterBody2D
class_name Player

## Gets the child of PrimaryAction node with index 0
@onready var primary_action: Node = null
## Gets the child of SecondaryAction node with index 0
@onready var secondary_action: Node = null
## Gets the child of DefensiveAction node with index 0
@onready var defensive_action: Node = null

@export var controller_look_deadzone: float = 0.3
@onready var game_manager = $"/root/GameManager"

## Runtime variable to denote if the last input was controller or MNK
var is_mnk: bool = true

func _ready():
	add_to_group("Player")
	primary_action = get_node_or_null("PrimaryAction")
	if primary_action!=null: primary_action = primary_action.get_child(0)
	secondary_action = get_node_or_null("SecondaryAction")
	if secondary_action!=null: secondary_action = secondary_action.get_child(0)
	defensive_action = get_node_or_null("DefensiveAction")
	if defensive_action!=null: defensive_action = defensive_action.get_child(0)

# Check if the latest input event is mnk or controller
func _input(event):
	if (event is InputEventKey) or (event is InputEventMouseButton):
		is_mnk = true
	elif (event is InputEventJoypadButton) or (event is InputEventJoypadMotion):
		is_mnk = false

func _process(delta):
	_check_input()
	

func _physics_process(delta):
	_face_player()
	move_and_slide()

func _check_input():
	# Check if primary action is not null
	if primary_action:
		if Input.is_action_just_pressed("primary_action"): primary_action.use()
	# Check if secondary action is not null
	if secondary_action:
		if Input.is_action_pressed("secondary_action"): secondary_action.use()
		elif Input.is_action_pressed("secondary_action") == false && secondary_action.has_method("stop_firing"): secondary_action.stop_firing()
	# Check if defensive action is not null
	if defensive_action:
		if Input.is_action_just_pressed("defensive_action"): defensive_action.use()
	## Added swap character buttons, tied to the number of max players number keys.
	for i in GameManager.selected_characters.size():
		if Input.is_action_just_pressed("select_character"+str(i+1)):
			game_manager.swap_character(i)
	
func _face_player():
	#check 
	if is_mnk:
		look_at(get_global_mouse_position())
	else:
		var look_direction = Vector2.ZERO
		look_direction.x = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X) # Get right joystick x
		look_direction.y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y) # Get right joystick y
		# if outside the deadzone, rotate player 
		if look_direction.length() >= controller_look_deadzone:
			rotation = look_direction.angle()
