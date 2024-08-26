extends Attack

@export_category("Player Settings")
# Get the animation player from the tree
@onready var anim_player: AnimationPlayer = $AnimationPlayer

## Var that can be changed in editor for a sound file that can be played
@export var sound_ref: AudioStream

## Cooldown on the ability in seconds
@export var cooldown_time: float = 1

func _ready():
	super()
	set_meta("custom_inspector", true)
# Overide for the base use
# Plays the attack
func use():
	if can_use:
		super()
		anim_player.play("sword_attack")
		can_use = false
		start_cooldown_timer()


func _on_area_2d_body_entered(body):
	body.get_node("HealthComponent").remove_health(damage)
