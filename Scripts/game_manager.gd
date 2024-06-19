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
var selected_characters: Array
## This is a variable used to store the index of the currently active character.
var active_character_index: int = 0
## An array of booleans that flag whether each selected character has been used in the current round.
var has_been_used: Array[bool] = [false, false, false]
## An array of health values for the three selected characters.
var character_health_values: Array[int]
## An int counter used to track the current round of the current run.
var round_number: int = 0
## A dictionary of all characters in the game, paired with boolean values for whether they are unlocked or not.
var character_dict = {"char_1": true, "char_2": true, "char_3": true, "char_4": false, "char_5": false}

var king_arthur_scene = preload("res://Scenes/Character/Player/king_arthur.tscn")
var robin_hood_scene = preload("res://Scenes/Character/Player/test_player.tscn")

func _ready():
	display_unlocked_characters()
	call_deferred("_find_characters")

## Updates currently active character. It should be called whenever you swap character.
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
