extends Node

signal died_signal

# Export variables
## Current health value as an integer
@export var health: int  = 0
## Max health value as an integer
@export var max_health: int = 100
## Timer for immunity in seconds as a float
@export var immunity_timer_value: float = 1.0
## Armour value as an integer
@export var armour: int = 2
## Magic Resist as an integer
@export var magic_resist: int = 1

# Object References
@onready var i_frame_timer: Timer = $IFramesTimer

# Runtime Variables
var is_immune: bool =  false



func add_health(amount: int) -> void:
	health += amount
	# Check and reset health if it goes over max
	if health > max_health:
		health = max_health

func remove_health(amount: int, damage_type: DamageType.Type = DamageType.Type.PHYSICAL) -> void:
	# If immune, exit
	if is_immune: return
	
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
	i_frame_timer.start(immunity_timer_value)
	is_immune = true
	if health <= 0:
		died_signal.emit()

func add_immunity(immune_time: float):
	is_immune = true
	i_frame_timer.start(immune_time)

func _on_i_frames_timer_timeout():
	is_immune = false
