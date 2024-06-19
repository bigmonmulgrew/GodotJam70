extends Area2D

var health_component
@export var respawn_time: float = 3
var respawn_timer: Timer = null

func start_respawn_timer(time: float = respawn_time) -> void:
	# Check if timer is null and create first.
	if respawn_timer == null: create_timer()
	
	# Start the timer
	respawn_timer.start(time)

func _on_respawn_timer_timeout() -> void:
	print("I HAVE RESPAWNED")
	#b_is_active = true
	
func create_timer():
	# Make a timer
	respawn_timer = Timer.new()
	# Add as a child
	add_child(respawn_timer)
	# Connnect the signal to renable can_use
	respawn_timer.timeout.connect(_on_respawn_timer_timeout)
	# Stop the timer from looping
	respawn_timer.one_shot = true

func _on_body_exited(body):
	health_component = body.get_node("HealthComponent")
	if health_component:
		health_component.remove_health((health_component.max_health * 0.5)) # damage type defaults to physical
		start_respawn_timer(respawn_time)
