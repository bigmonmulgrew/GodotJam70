@tool
extends CharacterBody2D
class_name Boss

## Base boss script to inherit from.
## [br]
## Needs a health component to be added.
## [br]Needs two Node2D added that are called "MeleeActions" and "RangedActions".

#region Object References
## Health component for the boss.
var health_component: HealthComponent:
	get:
		return get_node("HealthComponent") # Tries to find the HealthComponent.
	set(value):
		health_component = value # Set the health component if found.
		if Engine.is_editor_hint():
			update_configuration_warnings()

var melee_actions: Node2D:
	get:
		return get_node("MeleeActions") # Tries to find a node2d called MeleeActions.
	set(value):
		melee_actions = value # Set the melee actions node if found.
		if Engine.is_editor_hint():
			update_configuration_warnings()

var ranged_actions: Node2D:
	get:
		return get_node("RangedActions") # Tries to find a node2d called RangedActions.
	set(value):
		ranged_actions = value # Set the melee actions node if found.
		if Engine.is_editor_hint():
			update_configuration_warnings()
#endregion

func _physics_process(delta):
	ranged_actions.look_at(get_player_location())

## Gets the active character from the gameplay manager
func get_player_location() -> Vector2:
	if GameManager.active_character_index >= 0:
		return GameManager.selected_characters[GameManager.active_character_index].global_position
	else:
		return global_position

# Inform the user that a health component needs to be added.
func _get_configuration_warnings() -> PackedStringArray:
	# If no health component is found, add a warning.
	if health_component == null:
		return ["No HealthComponent node found."]
	# If no melee actions node is found, add a warning.
	if melee_actions == null:
		return ["No MeleeActions node found."]
	# If no ranged actions node is found, add a warning.
	if ranged_actions == null:
		return ["No RangedActions node found."]
	return []
