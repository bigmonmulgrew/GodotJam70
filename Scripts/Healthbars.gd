extends CanvasLayer
#region player variables
## The players maximum health 
var player_max_health: int
## The players current health
var player_current_health: int
## The target position of the players healthbar
var player_current_health_pos: float
## The movement scale of the healthbar
var player_bar_rate: float = 0.02
## The texture for player health bar
@onready var player_bar: TextureProgressBar = $PlayerHealthBar
## Once player_image and player_texture is set do this: player_icon.texture = player_texture
@onready var player_icon = $PlayerHealthBar/PlayerIcon
## The displayed name for the player
@onready var player_name = $PlayerHealthBar/PlayerName

## The players maximum resource
var player_max_resource: int
## The players current resource
var player_current_resource: int
## The target position of the players resource bar
var player_current_resource_pos: float
## The movement scale of the resource bar
var player_resource_rate: float = 0.02
## The texture for the player resource bar
@onready var resource_bar: TextureProgressBar = $PlayerResourceBar
#endregion

#region boss variables
## The bosses maximum health
var boss_max_health: int
## The bosses current health
var boss_current_health: int
## The target position of the bosses healthbar
var boss_current_health_pos: float
## The movement scale of the bosses healthbar
var boss_bar_rate: float = 0.02
## The texture for the boss health bar
@onready var boss_bar: TextureProgressBar = $BossHealthBar
## Once the boss_image and boss_texture is set do this: boss_icon.texture = boss_texture
@onready var boss_icon = $BossHealthBar/BossIcon
## The displayed name for the boss
@onready var boss_name = $BossHealthBar/BossName
#endregion

#region ally variables
## first ally's max health
var ally_one_max_health: int
## first ally's current health
var ally_one_current_health: int
## The texture for the first ally's health bar
@onready var ally_health_bar_1 = $PlayerHealthBar/AllyHealthBar1
## Once the ally_one_image and ally_one_texture is set do this: ally_icon_1 = ally_one_texture
@onready var ally_icon_1 = $PlayerHealthBar/AllyHealthBar1/AllyIcon1

## second ally's max health
var ally_two_max_health: int
## second ally's current health
var ally_two_current_health: int
## The texture for the second ally's health bar
@onready var ally_health_bar_2 = $PlayerHealthBar/AllyHealthBar2
## Once the ally_two_image and ally_two_texture is set do this: ally_icon_2 = ally_two_texture
@onready var ally_icon_2 = $PlayerHealthBar/AllyHealthBar2/AllyIcon2
#endregion

#region _move_bar
func _move_bar(current_value: int, max_value: int, current_pos: float, rate: float, bar: TextureProgressBar) -> float:
	if current_value > current_pos:
		current_pos += rate
	elif current_value < current_pos:
		current_pos -= rate
	bar.value = current_pos
	return(current_pos)
#endregion

#region interface methods
	#region player health functions
func _set_player_health(current_health: int):
	player_current_health = current_health
func _set_player_max_health(max_health: int):
	player_max_health = max_health
func _set_player_health_pos(health_pos: float):
	player_current_health_pos = health_pos
#endregion
	#region player resource functions
func _set_current_resource(current_resource: int):
	player_current_resource = current_resource
func _set_max_resource(max_resrouce: int):
	player_max_resource = max_resrouce
func _set_resource_pos(resource_pos: float):
	player_current_health_pos = resource_pos
#endregion
	#region boss health functions
func _set_boss_health(current_health: int):
	boss_current_health = current_health
func _set_boss_max_health(max_health: int):
	boss_max_health = max_health
func _set_boss_health_pos(health_pos: float):
	boss_current_health_pos = boss_current_health_pos
#endregion
	#region ally 1 functions
func _set_ally_one_health(current_health: int):
	ally_one_current_health = current_health
func _set_ally_one_max_health(max_health: int):
	ally_one_max_health = max_health
#endregion
	#region ally 2 functions
func _set_ally_two_health(current_health: int):
	ally_two_current_health = current_health
func _set_ally_two_max_health(max_health: int):
	ally_two_max_health = max_health
#endregion
#endregion

#region _process
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_current_health_pos = _move_bar(
		player_current_health, 
		player_max_health, 
		player_current_health_pos, 
		player_bar_rate, 
		$PlayerHealthBar
	)
	player_current_resource_pos = _move_bar(
		player_current_resource_pos,
		player_max_resource,
		player_current_resource_pos,
		player_resource_rate,
		$PlayerResourceBar
	)
	boss_current_health_pos = _move_bar(
		boss_current_health, 
		boss_max_health, 
		boss_current_health_pos,
		boss_bar_rate,
		$BossHealthBar
	)
	
	#setting the wobble
	#It doesn't like being in a function :(
	player_bar.texture_progress.speed_scale = player_max_health - player_current_health_pos
	boss_bar.texture_progress.speed_scale = boss_max_health - boss_current_health_pos
	resource_bar.texture_progress.speed_scale = player_max_health - player_current_health_pos
	
	#updating bars
	ally_health_bar_1.value = ally_one_current_health
	ally_health_bar_2.value = ally_two_current_health
#endregion
	
#region image setting methods
## function for setting the player's icon. input: image path
func _set_player_icon(image_path: String) -> void:
	var player_image
	var player_texture
	player_image = Image.load_from_file(image_path)
	player_texture = ImageTexture.create_from_image(player_image)
	player_icon.texture = player_texture

## function for setting the boss' icon. input: image path
func _set_boss_icon(image_path: String) -> void:
	var boss_image
	var boss_texture
	boss_image = Image.load_from_file(image_path)
	boss_texture = ImageTexture.create_from_image(boss_image)
	boss_icon.texture = boss_texture
	
## function for setting the first ally's icon. input: image path
func _set_ally_one_icon(image_path: String) -> void:
	var ally_one_image
	var ally_one_texture
	ally_one_image = Image.load_from_file(image_path)
	ally_one_texture = ImageTexture.create_from_image(ally_one_image)
	ally_icon_1.texture = ally_one_texture
	
## function for setting the second ally's icon. input: image path
func _set_ally_two_icon(image_path: String) -> void:
	var ally_two_image
	var ally_two_texture
	ally_two_image = Image.load_from_file(image_path)
	ally_two_texture = ImageTexture.create_from_image(ally_two_image)
	ally_icon_2.texture = ally_two_texture
	
#endregion

#region name setting methods
## function for setting the player's name. input: String
func _set_player_name(name: String):
	player_name.text = name
	
## function for setting the player's name. input: String
func _set_boss_name(name: String):
	boss_name.text = name
#endregion
