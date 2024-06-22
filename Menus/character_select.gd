extends Control

@export_file("*.tscn") var target_Level_level_1
@export_file("*.tscn") var target_Level_main_menu
var game_manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_tree().get_root().get_node("GameManager")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_button_pressed() -> void:
	var character_counter = 0
	if game_manager.selected_characters.size() == 2:
		LevelMaster.load_level(target_Level_level_1)
		#get_tree().change_scene_to_file(target_Level_level_1) # Will only load the level if there are two characters selected. Bump to three in final game!
	else:
		print("You need to select a character!")

func _on_back_button_pressed() -> void:
	LevelMaster.load_level(target_Level_main_menu)
	#get_tree().change_scene_to_file(target_Level_main_menu)

func _character_pass(name:String, nodeP:NodePath):
	var active:bool = game_manager.character_select_option(name)
	var ButtonRef =	get_tree().root.get_node(nodeP)
	print(ButtonRef)
	if active: ButtonRef.add_theme_color_override("normal",Color(1,0,0,1))
	else: ButtonRef.add_theme_color_override("normal",Color(0,0,0,1))

func _get_p_my_g(nodeP:NodePath):
	print(nodeP)
