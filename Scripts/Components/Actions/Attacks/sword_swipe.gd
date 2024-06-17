extends Attack

# Get the animation player from the tree
@onready var anim_player: AnimationPlayer = $AnimationPlayer

# Overide for the base use
# Plays the attack
func use():
	if can_use:
		anim_player.play("sword_attack")
		can_use = false
		start_cooldown_timer()


func _on_area_2d_body_entered(body):
	body.get_node("HealthComponent").remove_health(damage)
