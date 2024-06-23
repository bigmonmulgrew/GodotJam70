extends Boss

enum State { ALIVE, DIED }
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_timer = $DeathTimer
@onready var attack_timer = $AttackTimer
@onready var path_follow: PathFollow2D = get_parent()


var current_state = State.ALIVE

func _physics_process(delta):
	path_follow.progress += 100 * delta
	var direction = global_position.direction_to(get_player_location())
	ranged_actions.rotation = atan2(direction.y, direction.x)
	_process_state()

func _boss_died():
	current_state = State.DIED
	
func _process_state():
	match current_state:
		State.DIED:
			animated_sprite.play("death")
			death_timer.start()


func _on_health_component_died_signal():
	_boss_died()


func _on_timer_timeout():
	SaveSystem.save_data(0, "RiverCascade", true)
	SaveSystem.save_data(0, "WoodlandHouse", true)	
	GameManager.load_level_from_collection()

func _on_attack_timer_timeout():
	ranged_actions.get_children().pick_random().use()
