extends Node2D
class_name Attack

@export var damage: int = 10

# This is a template class to extend
# Use this to guarantee that attacks have a use method and will not
# crash when being used in a player or boss

func use():
	print("Use not yet implemented in this attack")
