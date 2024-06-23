extends "res://Scripts/Components/Actions/Attacks/attack_base.gd"

#region Object Rederences
## Reference to the animation player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion

## Var that can be changed in editor for a sound file that can be played
@export var sound_ref: AudioStream


func use():
	animation_player.play("tentacle_attack")
	
	##Play the audio SFX
	AudioManager.play_sfx(sound_ref,1,-30)


func _on_area_2d_body_entered(body):
	var body_health_component = body.get_node("HealthComponent")
	if body_health_component:
		body_health_component.remove_health(damage, damage_type)
