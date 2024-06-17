extends Node2D


@export_file("*.tscn") var target_Level_next

@onready var player: CharacterBody2D = $KingArthur
@onready var health_bar: TextureProgressBar = $CanvasLayer/HealthBar
@onready var resource_bar: TextureProgressBar = $CanvasLayer/ResourceBar



func _ready():
	health_bar_ui.player_max_health = player.get_node("HealthComponent").max_health
	health_bar_ui.player_max_resource = player.get_node("ResourceComponent").resource_cap

func _process(delta):
	delete_me1()
	delete_me2()
	delete_me3()
	delete_me4()

func delete_me1():
	# Use this to place code to not interfear with other debug code
	# Update Healthbar

	health_bar_ui.player_current_health = player.get_node("HealthComponent").health
	if Input.is_action_just_pressed("right_mouse_button"):

		player.get_node("HealthComponent").add_health(10)
	if Input.is_action_just_pressed("secondary_action"):
		player.get_node("HealthComponent").remove_health(10)


	# Update Resourcebar
	resource_bar.value = player.get_node("ResourceComponent").current_resource
	
func delete_me2():
	# Use this to place code to not interfear with other debug code
	pass
	
func delete_me3():
	# Use this to place code to not interfear with other debug code
	pass
	
func delete_me4():
	# Use this to place code to not interfear with other debug code
	# Dave doing debugging here
	if Input.is_action_just_pressed("ui_text_completion_query"):
		get_tree().change_scene_to_file(target_Level_next)
	

