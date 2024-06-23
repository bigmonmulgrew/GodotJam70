extends Node
class_name LevelManager

var Loading:bool = false
var CurrentLevelPath = ""
const GAME_OVER = preload("res://Menus/game_over.tscn")
signal transition_sig

var dontunlod_nodes:Array[Node]

func _ready():
	#set default reload address to the current scene
	CurrentLevelPath = (get_tree().current_scene.scene_file_path.replace("res://",""))

##Loads level from adress in Levels folder
func load_level(Path:String):
	if !Loading :
		Loading = true
		var lastTime = $TransitionPlayer.current_animation_position
		$TransitionPlayer.play("FadeOut")
		#not really a fix but, I'm o blame dat on daveo, prase be the great merger
		$TransitionPlayer.seek((($TransitionPlayer.current_animation_length-lastTime)/$TransitionPlayer.current_animation_length)*$TransitionPlayer.get_animation("FadeIn").length)
		await get_tree().create_timer($TransitionPlayer.get_animation("FadeOut").length).timeout
		$TransitionPlayer.play("FadeIn")
		transition_sig.emit()
		get_tree().unload_current_scene()
		get_tree().change_scene_to_file("res://"+Path)
		CurrentLevelPath = Path
		Loading = false

func load_game_over():
	var game_over_path = GAME_OVER.resource_path.replace("res://","")
	load_level(game_over_path)
	
##reloads current level
func reload_level():
	CurrentLevelPath = (get_tree().current_scene.scene_file_path.replace("res://",""))
	load_level(CurrentLevelPath)
