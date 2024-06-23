extends Boss

enum State{ WALK_N, WALK_NE, WALK_E, WALK_SE, WALK_S, WALK_SW, WALK_W, WALK_NW }

#region Object References
@onready var animated_sprite: AnimatedSprite2D = $MerlinAnims
#endregion

#region Runtime Variables
var current_state: State = State.WALK_S
var speed: float = 40
var anim_move_tolerance: float = 0.1
#endregion

func _physics_process(delta):
	super(delta)
	_update_state()
	_process_state()
	_test_movement()
	move_and_slide()
	
func _update_state():
	var norm_velocity = velocity.normalized()
	print(norm_velocity)
	# Check walk north east
	if norm_velocity.x > anim_move_tolerance and norm_velocity.y < anim_move_tolerance:
		current_state = State.WALK_NE
	# Check walk south east
	elif norm_velocity.x > anim_move_tolerance and norm_velocity.y > -anim_move_tolerance:
		current_state = State.WALK_SE
	elif (norm_velocity.x < anim_move_tolerance or norm_velocity.x > -anim_move_tolerance) and norm_velocity.y < 0: 
		current_state = State.WALK_N
	# Check walk east
	elif norm_velocity.x > 0 and (norm_velocity.y < anim_move_tolerance or norm_velocity.y > -anim_move_tolerance): 
		current_state = State.WALK_E
	# Check walk south
	elif (norm_velocity.x < anim_move_tolerance or norm_velocity.x > -anim_move_tolerance) and norm_velocity.y > 0: 
		current_state = State.WALK_S
	# Check walk west
	elif norm_velocity.x < 0 and (norm_velocity.y < anim_move_tolerance or norm_velocity.y > -anim_move_tolerance): 
		current_state = State.WALK_W

func _process_state():
	match current_state:
		State.WALK_N:
			animated_sprite.play("WalkN")
		State.WALK_E:
			animated_sprite.play("WalkE")
		State.WALK_S:
			animated_sprite.play("WalkS")
		State.WALK_W:
			animated_sprite.play("WalkW")
		State.WALK_NE:
			animated_sprite.play("WalkNE")
		State.WALK_SE:
			animated_sprite.play("WalkSE")
		State.WALK_SW:
			animated_sprite.play("WalkSW")
		State.WALK_NW:
			animated_sprite.play("WalkNW")
			
	print(current_state)

func _test_movement():
	velocity = global_position.direction_to(get_player_location()) * speed
