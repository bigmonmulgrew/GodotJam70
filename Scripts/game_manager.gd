extends Node
class_name Game_Manager

## Game state autoload scene.
## 
## Game_Manager is an autoload scene that carries data between scenes. This is used because Godot likes to drop everything between scenes.
## [br]
## Since many of us come from Unreal, think of this as a GameMode.
## [br]
## [br]
## This tracks the currently selected characters, the currently active character, whether each character has been used during a fight, the health values of each character, the round number of the current boss fight, and a dictionary of all playable characters in the game and whether they are currently unlocked or not.
## [br]
## [br]
## The Game_Manager interacts with the "players" group, which gives an array of characters in the scene.
## [br]
## [br]
## Certain methods should be called from other scripts. E.g. update_active_character should be called whenever you swap character. The appropriate time to call each method will be included in its description.

## A list of characters that are selected for the current run.
var selected_characters: Array[Node]
## This is a variable used to store the index of the currently active character.
var active_character_index: int = 0
## An array of booleans that flag whether each selected character has been used in the current round.
var has_been_used: Array[bool] = [false, false, false]
## An array of health values for the three selected characters.
var character_health_values: Array[int]
## An int counter used to track the current round of the current run.
var round_number: int = 0

##character section

## A dictionary of all characters in the game, paired with boolean values for whether they are unlocked or not.
var character_dict = {"char_1": true, "char_2": true, "char_3": true, "char_4": false, "char_5": false}
## A preload of the KingArthur character scene, which can be switched to if it is part of the selected_characters pool.
var king_arthur_scene = preload("res://Scenes/Character/Player/king_arthur.tscn")
## A preload of the RobinHood test player character scene, which can be switched to if it is part of the selected_characters pool.
var robin_hood_scene = preload("res://Scenes/Character/Player/test_player.tscn")

#UPDATE!!!!------------------------------------------
var grandma_wolf_scene = preload("res://Scenes/Character/Player/king_arthur.tscn")
## A preload of the RobinHood test player character scene, which can be switched to if it is part of the selected_characters pool.
var oberon_scene = preload("res://Scenes/Character/Player/test_player.tscn")

var goose_scene = preload("res://Scenes/Character/Player/king_arthur.tscn")
## A preload of the RobinHood test player character scene, which can be switched to if it is part of the selected_characters pool.
var sixth_character_scene = preload("res://Scenes/Character/Player/test_player.tscn")


const max_player_select = 3

func _ready():
	display_unlocked_characters()
	call_deferred("_find_characters")

## Updates currently active character. It is called whenever you swap character.
##[br]
##[br]
## This method takes in an integer, which represents the index of the newly-active character.
##[br]
##[br]
## update_active_character(1)
##[br]
## This would update the active character to index 1, which is the second character in the list.
## [br]
## [br]
## It also flags that the character has been used in this fight using the has_been_used array.
func update_active_character(index: int):
	active_character_index = index
	has_been_used[index] = true

## This method swaps the character from the current character to another character in the selected_character list.
##[br]
##[br]
## It takes in an index, which is supplied by player inputs. Pressing 1 will pass in index 0 (swap to character 1), pressing 2 will pass in index 1 (swap to character 2), etc.
##[br]
##[br]
## The method gets the level node. It then assings the current player in the level to a temp_player placeholder variable. E.g., if you are swapping FROM King Arthur to another character, temp_player becomes King Arthur.
##[br]
## The level player then becomes the newly-selected character. If you are swapping to Robin Hood, for example, then level.player now stores Robin Hood.
##[br]
## It then adds the newly-selected character to the scene, sets it's position to that of the temp_player, and then removes temp_player from the scene.
##[br]
## This leaves you with just one character in the scene - the one that you swapped to.
##[br]
## The active character index variable is then changed accordingly to match the currently-played character.
func swap_character(index: int):
	if index != active_character_index:
		var level = get_tree().get_root().get_node("TEMPTEST")
		var temp_player = level.player
		level.player = selected_characters[index]
		get_tree().get_root().add_child(level.player)
		level.player.global_position = temp_player.global_position
		temp_player.get_parent().remove_child(temp_player)
		update_active_character(index)

## Respawn character takes the position of the player, removes them from the tree, and then adds them back onto the tower after a few seconds.
##[br]
## To move them back onto the tower, it gets a direction vector from where they "fell" towards the centre of the tower and sets the position of the respawned player to be slightly closer to the centre of the tower. This should always move them back onto the tower near where they initially fell.
##[br]
## It's not perfect, but it works for now.
func respawn_character():

	var level = get_tree().get_root().get_node("TEMPTEST")
	var stored_player = level.player
	var player_position = level.player.global_position
	var tower_centre_pos = (get_tree().get_root().get_node("TEMPTEST").get_node("Tower Centre").global_position)
	var direction_to_centre = (tower_centre_pos-player_position).normalized() # find position of tower centre node and put it before player_pos
	var respawn_pos = player_position + (200 * direction_to_centre)
	
	get_tree().get_root().remove_child(level.player)
	await get_tree().create_timer(3.0).timeout
	get_tree().get_root().add_child(stored_player)
	stored_player.global_position = respawn_pos
	
## Prints the key, value pairs from the character dictionary.
func display_unlocked_characters():
	for character in character_dict:
		var unlocked = character_dict[character]
		print("Character: " + str(character) + ", Status: " + str(unlocked))

## Populates the selected_chatacters array with all characters in the "players" group. This call is deffered in _ready(), so that it is called after the main scene has been instanced. This was necessary as autoloads are technically loaded before the main scene, which would cause issues as the players wouldn't have been spawned yet.
func _find_characters():
	for player in get_tree().get_nodes_in_group("players"):
		player = player as CharacterBody2D
		selected_characters.append(player)
	for character in selected_characters:
		print(character)
		print(character.get_node("HealthComponent").health)

## This updates the character_health_values array, so that the values for each character are stored between fights. This is called in end_round().
func update_health():
	for i in range(selected_characters.size()):
		character_health_values[i] = selected_characters[i].get_node("HealthComponent").health

## Adds 1 to the round counter. This is called in end_round().
func increment_round_counter():
	round_number += 1

## Heals unused characters, sets has_been_used to false for all characters to ready for next round, and then updates the health values to carry them into the next scene.
## [br]
## [br]
## This needs to be called when we end a round (when the player loses or when a boss is defeated?).
func end_round():
	for i in range(selected_characters.size()):
		if has_been_used[i] == false:
			selected_characters[i].get_node("HealthComponent").add_health(50)
	has_been_used = [false, false, false]
	update_health()
	
func character_select_option(name:String):
	var pass_object = null
	match (name.to_lower()):
		"king arthur":
			pass_object = king_arthur_scene
		"robin hood":
			pass_object = robin_hood_scene
		"grandma wolf":
			pass_object = oberon_scene
		"oberon":
			pass_object = robin_hood_scene
		"goose":
			pass_object = robin_hood_scene
		"sixth":
			pass_object = robin_hood_scene
	if pass_object != null:
		for character in selected_characters:
			if character.name == name: # If King Arthur is already on your team, remove him.
				selected_characters.erase(character)
				print("removed character ", name)
				return false
		var object_temp_instance = pass_object.instantiate()
		object_temp_instance.name = name
		selected_characters.append(object_temp_instance)
		#excessive checks useful for when function is called outside select screen
		if selected_characters.size() > max_player_select:
			selected_characters.remove_at(0)
		print("added character ", name)
		return true
	return null
	
