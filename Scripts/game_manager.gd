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

var queued_stages: Array[String] = []

##character section

## A dictionary of all characters in the game, paired with boolean values for whether they are unlocked or not.
@export var character_dict = {"char_1": true, "char_2": true, "char_3": true, "char_4": false, "char_5": false}
## A preload of the KingArthur character scene, which can be switched to if it is part of the selected_characters pool.
@export var king_arthur_scene = preload("res://Scenes/Character/Player/king_arthur.tscn")
## A preload of the RobinHood test player character scene, which can be switched to if it is part of the selected_characters pool.
@export var robin_hood_scene = preload("res://Scenes/Character/Player/robin_hood.tscn")

#UPDATE!!!!------------------------------------------
@export var grandma_wolf_scene = preload("res://Scenes/Character/Player/test_player.tscn")
## A preload of the RobinHood test player character scene, which can be switched to if it is part of the selected_characters pool.
@export var oberon_scene = preload("res://Scenes/Character/Player/oberon_the_fairy_king.tscn")

@export var goose_scene = preload("res://Scenes/Character/Player/test_player2.tscn")
## A preload of the RobinHood test player character scene, which can be switched to if it is part of the selected_characters pool.
@export var sixth_character_scene = preload("res://Scenes/Character/Player/mf_broom.tscn")


#Health Bars
var packed_health_bars = preload("res://Scenes/Healthbars.tscn")
var player_health_bar = packed_health_bars.instantiate()
const leveloptionsaves:Array[String] = ["WoodlandHouse", "RiverCascade", "MerlinsTower"]
var levellocations:Array[String] = ["Levels/River/river_level.tscn", "Levels/River/river_level.tscn", "Scenes/tower_area.tscn"]

const max_player_select = 3

func _ready():
	display_unlocked_characters()
	call_deferred("_find_characters")
	get_tree().get_root().add_child(player_health_bar)

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
		active_character_index = index
		print("This worked, current char index: " + str(active_character_index))
		#reworked dodge system
		var level = get_tree().current_scene
		var temp_player_ref:CharacterBody2D = null
		for i in get_tree().get_nodes_in_group("Player"):
			if i.get_parent() != null && is_instance_valid(i) :
				print("This worked4")
				temp_player_ref = i as CharacterBody2D
		#level.player = selected_characters[index]
		var pl_temp:CharacterBody2D = selected_characters[index] as CharacterBody2D
				
		if temp_player_ref != null:
			print("This worked3")
			temp_player_ref.get_parent().add_child(pl_temp)
			pl_temp.global_position = temp_player_ref.global_position
			pl_temp.velocity = temp_player_ref.velocity
			temp_player_ref.get_parent().remove_child(temp_player_ref)
			update_active_character(index)
			
func _detach_player_from_scene() -> void:
	print("gdgsrhggsrhsrh")
	var temp_player_ref:CharacterBody2D = null
	for i in get_tree().get_nodes_in_group("Player"):
		i.get_parent().remove_child(i)
	LevelMaster.transition_sig.disconnect(_detach_player_from_scene)

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
	for player in get_tree().get_nodes_in_group("Players"):
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
			pass_object = oberon_scene
		"goose":
			pass_object = goose_scene
		"sixth":
			pass_object = sixth_character_scene
	if pass_object != null:
		for character in selected_characters:
			if character.name == name: # If King Arthur is already on your team, remove him.
				selected_characters.erase(character)
				print("removed character ", name)
				return false
		var object_temp_instance = pass_object.instantiate()
		object_temp_instance.name = name
		
		if selected_characters.size() <= 0:
			active_character_index = 0
			
		selected_characters.append(object_temp_instance)
		#excessive checks useful for when function is called outside select screen
		if selected_characters.size() > max_player_select:
			selected_characters.remove_at(0)
		print("added character ", name)
		return true
	return null
	

func load_level_from_collection():
	var list_to_ref:Array[int]
	for i in leveloptionsaves.size():
		if SaveSystem.load_data(0,leveloptionsaves[i])!= null:
			list_to_ref.push_back(i)
	#pick uplayed level
	var rool = randi_range(0,list_to_ref.size()-1)
	#if it cant find any unbeaten level play all
	if list_to_ref.size() <= 0:
		rool = randi_range(0,leveloptionsaves.size()-1)
	LevelMaster.transition_sig.connect(_detach_player_from_scene)
	LevelMaster.load_level(levellocations[rool])
	

func on_health_changed(health_value: int):
	player_health_bar._set_player_health(health_value)
	
func on_resource_changed(resrouce_value: int):
	player_health_bar._set_current_resource(resrouce_value)
	
func kill_current_player():
	print("ht rt game" )
	
	if selected_characters.size() > 0:
		var to_delete = selected_characters[active_character_index]
		var tempList:Array[Node] = selected_characters.duplicate(true)
		tempList.remove_at(active_character_index)
		var tm = clamp(active_character_index,0,tempList.size()-1)
		swap_character(tm)
		
		selected_characters.assign(tempList)
		print(selected_characters, " I ", active_character_index)
		
		to_delete.queue_free()
	
	if selected_characters.size() <= 0:
		LevelMaster.load_game_over()
		active_character_index = -1
