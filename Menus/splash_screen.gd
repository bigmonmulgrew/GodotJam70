extends Control

@export_file("*.tscn") var target_Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	
	_load_level()

func _load_level() -> void:
	get_tree().change_scene_to_file(target_Level)
