extends Node
class_name Game_Manager

var selected_characters: Array[Node]
var active_character_index: int = 0
var has_been_used: Array[bool] = [false, false, false]
var character_health_values: Array[int]
var round_number: int = 0
var character_dict = {"char_1": true, "char_2": true, "char_3": true, "char_4": false, "char_5": false}

func _ready():
	display_unlocked_characters()
	call_deferred("_find_characters")

## Updates currently active character when you swap character.
##[br]
##[br]
## This method takes in an integer, which represents the index of the newly-active character.
##[br]
##[br]
## update_active_character(1)
##[br]
## This would update the active character to index 1, which is the second character in the list.
func update_active_character(index: int):
	active_character_index = index
	has_been_used[index] = true
	
func display_unlocked_characters():
	for character in character_dict:
		var unlocked = character_dict[character]
		print("Character: " + str(character) + ", Status: " + str(unlocked))

func _find_characters():
	selected_characters = get_tree().get_nodes_in_group("players")
	for character in selected_characters:
		print(character)
		print(character.get_node("HealthComponent").health)

func update_health():
	for i in range(selected_characters.size()):
		character_health_values[i] = selected_characters[i].get_node("HealthComponent").health

func increment_round_counter():
	round_number += 1

func end_round():
	for i in range(selected_characters.size()):
		if has_been_used[i] == false:
			selected_characters[i].get_node("HealthComponent").add_health(50)
	has_been_used = [false, false, false]
	update_health()
