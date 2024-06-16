extends Node2D

@onready var player: CharacterBody2D = $Character
@onready var health_bar_ui = $HealthBarUI


func _ready():
	health_bar_ui.player_max_health = player.get_node("HealthComponent").max_health
	health_bar_ui.player_max_resource = player.get_node("ResourceComponent").resource_cap

func _process(delta):
	# Update Healthbar
	health_bar_ui.player_current_health = player.get_node("HealthComponent").health
	if Input.is_action_just_pressed("right_mouse_button"):
		player.get_node("HealthComponent").add_health(10)
	if Input.is_action_just_pressed("left_mouse_button"):
		player.get_node("HealthComponent").remove_health(10)
