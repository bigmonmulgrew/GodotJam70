extends Control

@export_file("*.tscn") var target_Level_main_menu
var credit_title_array = [
	"Credits",
	"Credits",
	"Credits",
	"Cridets",
	"Meet The Team",
	"Meet The Team",
	"Meet The Team",
	"Meat The Team",
	"Hall Of Idiots",
	"The Guys Who Did The Thing"
	]
	
var array_number: int
@onready var credit_title = $CreditTitle
@export var credit_audio_array: Array[AudioStream] = [AudioStream.new()]
var funny_timer: float
var funny_bool: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	array_number = randf_range(1,len(credit_title_array))
	credit_title.text = credit_title_array[array_number]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	funny_timer -= delta
	if funny_timer <= 0 and funny_bool == true:
		array_number = randf_range(1,len(credit_title_array))
		credit_title.text = credit_title_array[array_number]
		funny_bool = false

func _on_return_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(target_Level_main_menu)
	

#region credit buttons
func _credit_button(soundnumber: int, link: String) -> void:
	AudioManager.play_sfx(credit_audio_array[soundnumber])
	OS.shell_open(link)
	funny_timer = 5
	funny_bool = true
