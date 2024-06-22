extends Control

@export_file("*.tscn") var target_Level_level_1
@export_file("*.tscn") var target_Level_main_menu

@export var color_button_select:Color = Color(0,0,0.8,0.75)
@export var color_button_default:Color = Color(0,0,0,0.75)

var game_manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_tree().get_root().get_node("GameManager")
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = color_button_default
	for but in get_children():
		var is_but = but as Button
		if is_but != null && but.name.begins_with("Select"):
			is_but.add_theme_stylebox_override("normal", stylebox)

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

func _character_pass(name: String, ButtonRef: Button):
	var active: bool = game_manager.character_select_option(name)

	var stylebox = StyleBoxFlat.new()
	if active:
		stylebox.bg_color = color_button_select # Red color
	else:
		stylebox.bg_color = color_button_default # Yellow color

	ButtonRef.add_theme_stylebox_override("normal", stylebox)
	ButtonRef.add_theme_stylebox_override("hover", stylebox) # Also change hover state if needed
	ButtonRef.add_theme_stylebox_override("pressed", stylebox) # Also change pressed state if needed

#super dirty but tis the godot method

func _on_select_character_1_button_pressed() -> void:
	_character_pass("King Arthur", $ButtonControl/Select_Character1_Button)
func _on_select_character_2_button_pressed() -> void:
	_character_pass("Robin Hood", $ButtonControl/Select_Character2_Button)
