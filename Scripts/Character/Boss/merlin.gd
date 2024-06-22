extends Boss

enum State{ WALK_N, WALK_NE, WALK_E, WALK_SE, WALK_S, WALK_SW, WALK_W, WALK_NW }

#region Object References
@onready var animated_sprite: AnimatedSprite2D = $MerlinAnims
#endregion

#region Runtime Variables
var current_state: State = State.WALK_S
#endregion

func _physics_process(delta):
	super(delta)
	_update_state()
	_process_state()
	
func _update_state():
	match velocity.normalized():
		Vector2.UP:
			current_state = State.WALK_N
		Vector2.RIGHT:
			current_state = State.WALK_E
		Vector2.DOWN:
			current_state = State.WALK_S
		Vector2.LEFT:
			current_state = State.WALK_E
		Vector2(1, -1):
			current_state = State.WALK_NE
		Vector2(1, 1):
			current_state = State.WALK_SE
		Vector2(-1, 1):
			current_state = State.WALK_SW
		Vector2(-1, -1):
			current_state = State.WALK_NW

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
