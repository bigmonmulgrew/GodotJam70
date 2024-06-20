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
		get_tree().change_scene_to_file(target_Level_level_1) # Will only load the level if there are two characters selected. Bump to three in final game!
	else:
		print("You need to select a character!")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(target_Level_main_menu)

## This method ties to the select character 1 button. It allows you to add or remove King Arthur from your team.
func _on_select_character_1_button_pressed():
	for character in game_manager.selected_characters:
		if character.name == "IAmKingArthur": # If King Arthur is already on your team, remove him.
			game_manager.selected_characters.erase(character)
			return
	var king_arthur_instance = game_manager.king_arthur_scene.instantiate()
	king_arthur_instance.name = "IAmKingArthur"
	game_manager.selected_characters.append(king_arthur_instance) # Add King Arthur to your team.

## This method ties to the select character 1 button. It allows you to add or remove Robin Hood from your team.
func _on_select_character_2_button_pressed():
	for character in game_manager.selected_characters:
		if character.name == "IAmRobinHood": # If Robin Hood is already on your team, remove him.
			game_manager.selected_characters.erase(character)
			return
	var robin_hood_instance = game_manager.robin_hood_scene.instantiate()
	robin_hood_instance.name = "IAmRobinHood"
	game_manager.selected_characters.append(robin_hood_instance) # Add Robin Hood to your team.
