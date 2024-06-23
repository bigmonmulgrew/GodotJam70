extends Control

@export_file("*.tscn") var target_Level_start_game
@export_file("*.tscn") var target_Level_credits
@export_file("*.tscn") var target_Level_options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_quit_game()

func _on_start_button_pressed() -> void:
	# Transition to the game scene
	LevelMaster.load_level(target_Level_start_game)
	#get_tree().change_scene_to_file(target_Level_start_game)
	
func _on_start_new_button_pressed() -> void:
	# Transition to the game scene
	SaveSystem.wipe_data(0)
	LevelMaster.load_level(target_Level_start_game)
	#get_tree().change_scene_to_file(target_Level_start_game)

func _on_quit_button_pressed() -> void:
	_quit_game()
	
func _quit_game():
	get_tree().quit()

func _on_credits_button_pressed() -> void:
	LevelMaster.load_level(target_Level_credits)
	#get_tree().change_scene_to_file(target_Level_credits)

func _on_options_button_pressed() -> void:
	LevelMaster.load_level(target_Level_options)
	#get_tree().change_scene_to_file(target_Level_options)
