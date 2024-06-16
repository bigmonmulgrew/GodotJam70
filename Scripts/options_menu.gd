extends Control
class_name OptionsMenu

@onready var close_button: Button = $MarginContainer/VBoxContainer/CloseButton

func _ready():
	# Make the menu invisible on start
	_set_visibility(false)

## Shows the menu on screen
func show_menu() -> void:
	_set_visibility(true)

func _on_close_button_pressed() -> void:
	_set_visibility(false)

# Changes processing and visibility of the UI
func _set_visibility(flag: bool) -> void:
	visible = flag
	set_process(flag)
