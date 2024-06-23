extends Boss

enum State { ALIVE, DIED }
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_timer = $DeathTimer
@onready var attack_timer = $AttackTimer


var current_state = State.ALIVE

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
	GameManager.load_level_from_collection()


func _on_attack_timer_timeout():
	ranged_actions.get_children().pick_random().use()
