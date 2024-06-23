extends Attack

# Get the animation player from the tree
@onready var anim_player: AnimationPlayer = $AnimationPlayer

## Var that can be changed in editor for a sound file that can be played
@export var sound_ref: AudioStream


# Overide for the base use
# Plays the attack
func use():
	if can_use:
		anim_player.play("sword_attack")

		##Play the audio SFX
		AudioManager.play_sfx(sound_ref,1,-30)
		can_use = false
		start_cooldown_timer()


func _on_area_2d_body_entered(body):
	body.get_node("HealthComponent").remove_health(damage)
