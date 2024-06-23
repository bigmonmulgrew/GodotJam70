extends Action
class_name IncreaseResist

## Node that will increase a resistance.
## [br]This will increase the armour on the HealthComponent for a set time.

#region Export Variables
## The value the armour gets set to when parry is used
@export var new_resist_amount: int = 20
## The time in seconds that the parry lasts for
@export var resist_time: float = 0.1
## The type of damage to resist.
@export var damage_type: DamageType.Type = DamageType.Type.PHYSICAL
#endregion

## Var that can be changed in editor for a sound file that can be played
@export var sound_ref: AudioStream



#region Object References
## Timer for how long the parry will last
@onready var resist_timer: Timer = $ResistTimer
## AnimationPlayer to show increased resist
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion

#region Runtime Variables
## Reference to the health component
var health_component: HealthComponent
var _temp_resist_value: int
#endregion

func _ready():
	super()
	health_component = owner.get_node("HealthComponent")

## Increases the armour of the health component
func use():
	# Exit if on cooldown
	if not can_use:
		return
	# Exit if no health component is found
	if not health_component:
		print("Health component not found for parry.")
		return

	# Play the animation
	if animation_player: animation_player.play("resist_active")
	else: print("Animation player not found on resist increase")


	##Play the audio SFX
	AudioManager.play_sfx(sound_ref,1,-30)

	print("Magic resist: " + str(health_component.magic_resist))
	print("Armour: " + str(health_component.armour))
	match damage_type:
		DamageType.Type.PHYSICAL:
			# Save current armour
			_temp_resist_value = health_component.armour
			# Set new armour
			health_component.armour = new_resist_amount
		DamageType.Type.MAGICAL:
			# Save current magic resist
			_temp_resist_value = health_component.magic_resist
			# Set new magic resist
			health_component.magic_resist = new_resist_amount
	# Start the timer for how long the parry will last
	resist_timer.start(resist_time)
	can_use = false
	# Start cooldown timer
	cooldown_timer.start(cooldown_time)
	print("Magic resist: " + str(health_component.magic_resist))
	print("Armour: " + str(health_component.armour))

func _on_resist_timer_timeout():
	# Reset resists back to normal
	match damage_type:
		DamageType.Type.PHYSICAL:
			health_component.armour = _temp_resist_value
		DamageType.Type.MAGICAL:
			health_component.magic_resist = _temp_resist_value
