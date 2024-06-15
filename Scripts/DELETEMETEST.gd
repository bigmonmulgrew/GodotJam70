extends Node2D

@onready var player: CharacterBody2D = $Character
@onready var health_bar: TextureProgressBar = $CanvasLayer/TextureProgressBar

func _ready():
	health_bar.max_value = player.get_node("HealthComponent").max_health

func _process(delta):
	health_bar.value = player.get_node("HealthComponent").health
	if Input.is_action_just_pressed("right_mouse_button"):
		player.get_node("HealthComponent").add_health(10)
	if Input.is_action_just_pressed("left_mouse_button"):
		player.get_node("HealthComponent").remove_health(10)
