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
	for character in game_manager.selected_characters:
		character_counter += 1
	if character_counter > 0:
		get_tree().change_scene_to_file(target_Level_level_1)
	else:
		print("You need to select a character!")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(target_Level_main_menu)


func _on_select_character_1_button_pressed():
	for character in game_manager.selected_characters:
		if character.name == "IAmKingArthur":
			print("KingArthur has been REMOVED from your team")
			game_manager.selected_characters.erase(character)
			print(game_manager.selected_characters)
			return
	var king_arthur_instance = game_manager.king_arthur_scene.instantiate()
	king_arthur_instance.name = "IAmKingArthur"
	game_manager.selected_characters.append(king_arthur_instance)
	print("KingArthur has been ADDED to your team")
	for character in game_manager.selected_characters:
		print(character)
		print(character.get_node("HealthComponent").health)


func _on_select_character_2_button_pressed():
	for character in game_manager.selected_characters:
		if character.name == "IAmRobinHood":
			print("RobinHood has been REMOVED from your team")
			game_manager.selected_characters.erase(character)
			print(game_manager.selected_characters)
			return
	var robin_hood_instance = game_manager.robin_hood_scene.instantiate()
	robin_hood_instance.name = "IAmRobinHood"
	game_manager.selected_characters.append(robin_hood_instance)
	print("RobinHood has been ADDED to your team")
	for character in game_manager.selected_characters:
		print(character)
		print(character.get_node("HealthComponent").health)
