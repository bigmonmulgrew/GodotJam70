@tool
extends CharacterBody2D
class_name Boss

#region Export Variables
## Health component for the boss.
var health_component: HealthComponent:
	get:
		return get_node("HealthComponent") # Tries to find the HealthComponent
	set(value):
		health_component = value # Set the health component if found
		if Engine.is_editor_hint():
			update_configuration_warnings()
#endregion

# Inform the user that a health component needs to be added
func _get_configuration_warnings() -> PackedStringArray:
	# If no health component is found, add a warning
	if health_component == null:
		return ["No health component added."]
	return []
