extends Node2D

@export_file("*.tscn") var target_Level_next
@onready var player: CharacterBody2D
@onready var health_bar_ui = $HealthBarUI
var game_manager

func _ready():
	game_manager = get_tree().get_root().get_node("GameManager")
	spawn_player_start()
	health_bar_ui.player_max_health = player.get_node("HealthComponent").max_health
	health_bar_ui.player_max_resource = player.get_node("ResourceComponent").resource_cap

func _process(delta):
	delete_me1()
	#delete_me2()
	delete_me3()
	delete_me4()

func spawn_player_start():
	player = game_manager.selected_characters[0]
	get_tree().get_root().add_child(player)

func delete_me1():
	# Use this to place code to not interfear with other debug code
	
	# Update Healthbar
	health_bar_ui.player_current_health = player.get_node("HealthComponent").health
	if Input.is_action_just_pressed("primary_action"):
		player.get_node("HealthComponent").add_health(10)
		
	if Input.is_action_just_pressed("secondary_action"):
		player.get_node("HealthComponent").remove_health(10)
	
func delete_me2():
	# Use this to place code to not interfear with other debug code
	# Update Healthbar
	health_bar_ui.player_current_health = player.get_node("HealthComponent").health
	if Input.is_action_just_pressed("primary_action"):
		LevelMaster.reload_level()
		#player.get_node("HealthComponent").add_health(10)
		
	if Input.is_action_just_pressed("secondary_action"):
		player.get_node("HealthComponent").remove_health(10)
	
func delete_me3():
	# Use this to place code to not interfear with other debug code
	pass
	
func delete_me4():
	# Use this to place code to not interfear with other debug code
	# Dave doing debugging here
	if Input.is_action_just_pressed("ui_text_completion_query"):
		get_tree().change_scene_to_file(target_Level_next)
	

