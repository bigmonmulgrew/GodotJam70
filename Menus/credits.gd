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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	array_number = randf_range(1,len(credit_title_array))
	print(array_number)
	credit_title.text = credit_title_array[array_number]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_return_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(target_Level_main_menu)
	

#region credit buttons
func _dave_button() -> void:
	AudioManager.play_sfx(credit_audio_array[0])
	OS.shell_open("https://weirdorconfusing.com/")
	
func _leeroy_button() -> void:
	AudioManager.play_sfx(credit_audio_array[1])
	OS.shell_open("https://linktr.ee/speedyeyeball")
	
func _gabe_button() -> void:
	AudioManager.play_sfx(credit_audio_array[2])
	OS.shell_open("https://the-kunk.itch.io/")
	
func _jacob_button() -> void:
	AudioManager.play_sfx(credit_audio_array[3])
	OS.shell_open("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
	
func _callum_button() -> void:
	AudioManager.play_sfx(credit_audio_array[4])
	OS.shell_open("https://optical.toys/")
	
func _hayden_button() -> void:
	AudioManager.play_sfx(credit_audio_array[5])
	OS.shell_open("https://maze.toys/mazes/mini/daily/")
	
func _niall_button() -> void:
	AudioManager.play_sfx(credit_audio_array[6])
	OS.shell_open("https://www.lingscars.com/")

func _DBEAN_button() -> void:
	AudioManager.play_sfx(credit_audio_array[7])
	OS.shell_open("https://cursoreffects.com/")
#endregion
