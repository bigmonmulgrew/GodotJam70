extends Control

@export_file("*.tscn") var target_Level_main_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_return_to_menu_button_pressed() -> void:
	LevelMaster.load_level(target_Level_main_menu)
	#get_tree().change_scene_to_file(target_Level_main_menu)
