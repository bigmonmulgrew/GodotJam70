extends Node
class_name HealthComponent

## Add this node to anything that wants a health component.
##
## Has the options for a max health, i-frame timer, armour and magic resist.

signal died_signal

# Export variables
## Value for current health.
@export var health: int  = 0
## Value used as max health.
@export var max_health: int = 100
## Timer for immunity on damage in seconds.
@export var immunity_timer_value: float = 1.0
## Value for reducing physical damage.
@export var armour: int = 2
## Value for reducing magic damage.
@export var magic_resist: int = 1

## Var that can be changed in editor for a sound file that can be played
@export var sound_ref: AudioStream


# Object References
@onready var _i_frame_timer: Timer = $IFramesTimer

# Runtime Variables
var _is_immune: bool =  false


## Function to add health.
## Takes an integer as a parameter.
## [br]Increases the health by the amount.
## [br]Will not go over max health.
func add_health(amount: int) -> void:
	health += amount
	# Check and reset health if it goes over max
	if health > max_health:
		health = max_health

## Function to remove health.
## [br]Takes an integer and a DamageType enum as a parameter.
## [br]Emits the died signal on going to zero or below.
func remove_health(amount: int, damage_type: DamageType.Type = DamageType.Type.PHYSICAL) -> void:
	# If immune, exit
	if _is_immune: return

	##Play the audio SFX
	AudioManager.play_sfx(sound_ref,1,-30)



	# Check damage type and apply relevant resists
	match damage_type:
		DamageType.Type.PHYSICAL:
			amount -= armour
		DamageType.Type.MAGICAL:
			amount -= magic_resist
		_:
			pass
	# Check if the damage to apply goes under 0 and reset
	if amount < 0: amount = 0
	
	health -= amount
	_i_frame_timer.start(immunity_timer_value)
	_is_immune = true
	if health <= 0:
		died_signal.emit()

## Function to add immunity to the health component.
## [br] Takes a float as a parameter.
## [br] Immunity time is in seconds.
## [br] Makes the health unable to take damage for the amount of time specified.
func add_immunity(immune_time: float):
	_is_immune = true
	_i_frame_timer.start(immune_time)

func _on_i_frames_timer_timeout():
	_is_immune = false
