extends Node2D

@onready var player: CharacterBody2D = $KingArthur
@onready var health_bar: TextureProgressBar = $CanvasLayer/HealthBar
@onready var resource_bar: TextureProgressBar = $CanvasLayer/ResourceBar

func _ready():
	health_bar.max_value = player.get_node("HealthComponent").max_health
	resource_bar.max_value = player.get_node("ResourceComponent").resource_cap

func _process(delta):
	# Update Healthbar
	health_bar.value = player.get_node("HealthComponent").health
	if Input.is_action_just_pressed("primary_action"):
		player.get_node("HealthComponent").add_health(10)
	if Input.is_action_just_pressed("secondary_action"):
		player.get_node("HealthComponent").remove_health(10)

	# Update Resourcebar
	resource_bar.value = player.get_node("ResourceComponent").current_resource
