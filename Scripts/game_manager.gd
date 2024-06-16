extends Node
class_name Game_Manager

var selected_characters
var active_character_index: int = 0
var character_health_values: Array[int]
var round_number: int = 0
var all_characters = ["char_1", "char_2", "char_3", "char_4", "char_5"]
var unlocked_characters = [true, true, true, false, false]

func _ready():
	print("GameManage _ready() called")
	call_deferred("_find_characters")
	call_deferred("increment_round_counter")
	update_active_character(1)

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
	
func display_unlocked_characters():
	for i in range(unlocked_characters.size()):
		if unlocked_characters[i]:
			print(all_characters[i])
#
func _find_characters():
	selected_characters = get_tree().get_nodes_in_group("players")
	for character in selected_characters:
		print(character)

func update_health():
	for i in range(selected_characters.size()):
		character_health_values[i] = selected_characters[i].get_node("HealthComponent").health

func increment_round_counter():
	round_number += 1
	
