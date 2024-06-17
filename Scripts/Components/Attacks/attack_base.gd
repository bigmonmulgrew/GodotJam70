extends Node2D
class_name Attack

## This is a template class to extend. 
## [br]Use this to guarantee that attacks have a use method and will not
## [br]crash when being used in a player or boss

# Export variables
## Damage value to apply
@export var damage: int = 10
## Cooldown on the ability in seconds
@export var cooldown_time: float = 1

# Runtime variables
## Use this to denote when you can take the action
var can_use: bool = true
## Timer node used for cooldown
var cooldown_timer: Timer = null

func _ready():
	# Make a timer
	cooldown_timer = Timer.new()
	# Add as a child
	add_child(cooldown_timer)
	# Connnect the signal to renable can_use
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	# Stop the timer from looping
	cooldown_timer.one_shot = true
	
## Template function for children
func use():
	print("Use not yet implemented in this attack")

## Function to start the cooldown timer.
## [br]Optional parameter to overide the cooldown time
func start_cooldown_timer(time: float = cooldown_time) -> void:
	# Start the timer
	cooldown_timer.start(time)

func _on_cooldown_timer_timeout() -> void:
	can_use = true
