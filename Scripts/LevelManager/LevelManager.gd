extends Node
class_name LevelManager

var Loading:bool = false
var CurrentLevelAdress = ""

var LevelFolder = "res://Levels/"

func _ready():
	#set default reload address to the current scene
	CurrentLevelAdress = (get_tree().current_scene.scene_file_path.replace(LevelFolder,""))

##Loads level from adress in Levels folder
func load_level(Level:String):
	if !Loading :
		Loading = true
		$TransitionPlayer.play("FadeOut",1)
		await get_tree().create_timer($TransitionPlayer.get_animation("FadeOut").length).timeout
		$TransitionPlayer.play("FadeIn",1)
		get_tree().unload_current_scene()
		get_tree().change_scene_to_file(LevelFolder+Level)
		CurrentLevelAdress = Level
		Loading = false

##reloads current level
func reload_level():
	load_level(CurrentLevelAdress)
