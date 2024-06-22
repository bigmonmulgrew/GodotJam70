extends Control

@export_file("*.tscn") var target_Level_level_1
@export_file("*.tscn") var target_Level_main_menu

@export var color_button_select:Color = Color(0,0,0.8,0.75)
@export var color_button_default:Color = Color(0,0,0,0.75)

#dodgey but checker array
var selected_but_list:Array[Button]

var game_manager:Game_Manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_tree().get_root().get_node("GameManager")
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = color_button_default
	for but in $ButtonControl.get_children():
		var is_but = but as Button
		if is_but != null && but.name.begins_with("Select"):
			is_but.add_theme_stylebox_override("normal", stylebox)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_button_pressed() -> void:
	var character_counter = 0
	if game_manager.selected_characters.size() >= 1:
		LevelMaster.load_level(target_Level_level_1)
		#get_tree().change_scene_to_file(target_Level_level_1) # Will only load the level if there are two characters selected. Bump to three in final game!
	else:
		print("You need to select a character!")

func _on_back_button_pressed() -> void:
	LevelMaster.load_level(target_Level_main_menu)
	#get_tree().change_scene_to_file(target_Level_main_menu)

## Deactivates and reactivates all active and not active buttons
func _unhighlight_selected_buttons():
	var stylebox_def = StyleBoxFlat.new()
	var stylebox_sel = StyleBoxFlat.new()
	stylebox_def.bg_color = color_button_default
	stylebox_sel.bg_color = color_button_select
	for but in $ButtonControl.get_children():
		var is_but = but as Button
		if is_but != null && but.name.begins_with("Select"):
			if selected_but_list.find(is_but)!=-1:
				is_but.add_theme_stylebox_override("normal", stylebox_sel)
				is_but.add_theme_stylebox_override("hover", stylebox_sel)
				is_but.add_theme_stylebox_override("pressed", stylebox_sel)
			else:
				is_but.add_theme_stylebox_override("normal", stylebox_def)
				is_but.add_theme_stylebox_override("hover", stylebox_def)
				is_but.add_theme_stylebox_override("pressed", stylebox_def)

func _character_pass(name: String, ButtonRef: Button):
	var active: bool = game_manager.character_select_option(name)
	
	if active:
		selected_but_list.push_back(ButtonRef)
		if selected_but_list.size() > game_manager.max_player_select:
			selected_but_list.remove_at(0)
	else:
		if(selected_but_list.find(ButtonRef)!=-1):
			selected_but_list.remove_at(selected_but_list.find(ButtonRef))

	_unhighlight_selected_buttons()
#super dirty but tis the godot method

func _on_select_character_1_button_pressed() -> void:
	_character_pass("King Arthur", $ButtonControl/Select_Character1_Button)
func _on_select_character_2_button_pressed() -> void:
	_character_pass("Robin Hood", $ButtonControl/Select_Character2_Button)
func _on_select_character_3_button_pressed() -> void:
	_character_pass("Grandma Wolf", $ButtonControl/Select_Character3_Button)
func _on_select_character_4_button_pressed() -> void:
	_character_pass("Oberon", $ButtonControl/Select_Character4_Button)
func _on_select_character_5_button_pressed() -> void:
	_character_pass("Goose", $ButtonControl/Select_Character5_Button)
func _on_select_character_6_button_pressed() -> void:
	_character_pass("Sixth", $ButtonControl/Select_Character6_Button)
