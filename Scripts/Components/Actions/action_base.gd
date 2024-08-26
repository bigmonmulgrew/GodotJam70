class_name Action extends Node

@export_category("Player Settings")
## Cooldown on the ability in seconds
@export var cooldown_time: float = 1
## The sound that will be played when the attack is used.
@export var use_sound: AudioStream

# Runtime variables
## Use this to denote when you can take the action
var can_use: bool = true
## Timer node used for cooldown
var cooldown_timer: Timer = null

func _ready():
	# Sometimes created befor ready is called so check for null firsst
	if cooldown_timer == null: create_timer()
	
## Call Super to activate common functions for use.
func use():
	##Play the audio SFX
	AudioManager.play_sfx(use_sound,1,-30)

## Function to start the cooldown timer.
## [br]Optional parameter to overide the cooldown time
func start_cooldown_timer(time: float = cooldown_time) -> void:
	# Check if timer is null and create first.
	if cooldown_timer == null: create_timer()
	
	# Start the timer
	cooldown_timer.start(time)

func _on_cooldown_timer_timeout() -> void:
	can_use = true
	
func create_timer():
	# Make a timer
	cooldown_timer = Timer.new()
	# Add as a child
	add_child(cooldown_timer)
	# Connnect the signal to renable can_use
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	# Stop the timer from looping
	cooldown_timer.one_shot = true
