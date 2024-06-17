extends CanvasLayer

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
## When setting do this: player_image = Image.load_from_file("file location")
var player_image
## When setting do this: player_texture = ImageTexture.create_from_image(player_image)
var player_texture

## The players maximum resource
var player_max_resource: int
## The players current resource
var player_current_resource: int
## The target position of the players resource bar
var player_current_resource_pos: float
## The movement scale of the resource bar
var player_resource_rate: float = 0.02
## The texture for the player resource bar
@onready var resource_bar: TextureProgressBar = $PlayerHealthBar/PlayerResourceBar

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
## When setting do this: boss_image = Image.load_from_file("file location")
var boss_image
## When setting do this: boss_texture = ImageTexture.create_from_image(boss_image)
var boss_texture

## first ally's max health
var ally_one_max_health: int
## first ally's current health
var ally_one_current_health: int
## The texture for the first ally's health bar
@onready var ally_health_bar_1 = $PlayerHealthBar/AllyHealthBar1
## Once the ally_one_image and ally_one_texture is set do this: ally_icon_1 = ally_one_texture
@onready var ally_icon_1 = $PlayerHealthBar/AllyHealthBar1/AllyIcon1
## When setting do this: ally_one_image = Image.load_from_file("file location")
var ally_one_image
## When setting do this: ally_one_texture = ImageTexture.create_from_image(ally_one_image)
var ally_one_texture

## second ally's max health
var ally_two_max_health: int
## second ally's current health
var ally_two_current_health: int
## The texture for the second ally's health bar
@onready var ally_health_bar_2 = $PlayerHealthBar/AllyHealthBar2
## Once the ally_two_image and ally_two_texture is set do this: ally_icon_2 = ally_two_texture
@onready var ally_icon_2 = $PlayerHealthBar/AllyHealthBar2/AllyIcon2
## When setting do this: ally_two_image = Image.load_from_file("file location")
var ally_two_image
## When setting do this: ally_two_texture = ImageTexture.create_from_image(ally_two_image)
var ally_two_texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#moving player health
	if player_current_health > player_current_health_pos:
		player_current_health_pos += player_bar_rate
	if player_current_health < player_current_health_pos:
		player_current_health_pos -= player_bar_rate
		
	#moving resource bar
	if player_current_resource > player_current_health_pos:
		player_current_resource_pos += player_resource_rate
	if player_current_resource < player_current_resource_pos:
		player_current_resource_pos -= player_resource_rate
	
	#moving boss health
	if boss_current_health > boss_current_health_pos:
		boss_current_health_pos += boss_bar_rate
	if boss_current_health < boss_current_health_pos:
		boss_current_health_pos -= boss_bar_rate
	
	#setting the wobble
	#TODO playerbar and resourcebar seems to be backwards in terms of "wobble" setting the resource effects playerbar and vice versa
	#¯\_(ツ)_/¯
	#doesn't effect how the bars work for tracking values just a cosmetic issue with a temp solution
	player_bar.texture_progress.speed_scale = player_max_resource - player_current_resource_pos
	boss_bar.texture_progress.speed_scale = boss_max_health - boss_current_health_pos
	resource_bar.texture_progress.speed_scale = player_max_health - player_current_health_pos
	
	#updating bars
	player_bar.value = player_current_health_pos
	boss_bar.value = boss_current_health_pos
	resource_bar.value = player_current_resource_pos
	ally_health_bar_1.value = ally_one_current_health
	ally_health_bar_2.value = ally_two_current_health
	
## function for setting the player's icon. input: image path
func _set_player_icon(image_path: String) -> void:
	player_image = Image.load_from_file(image_path)
	player_texture = ImageTexture.create_from_image(player_image)
	player_icon.texture = player_texture

## function for setting the boss' icon. input: image path
func _set_boss_icon(image_path: String) -> void:
	boss_image = Image.load_from_file(image_path)
	boss_texture = ImageTexture.create_from_image(boss_image)
	boss_icon.texture = boss_texture
	
## function for setting the first ally's icon. input: image path
func _set_ally_one_icon(image_path: String) -> void:
	ally_one_image = Image.load_from_file(image_path)
	ally_one_texture = ImageTexture.create_from_image(ally_one_image)
	ally_icon_1.texture = ally_one_texture
	
## function for setting the second ally's icon. input: image path
func _set_ally_two_icon(image_path: String) -> void:
	ally_two_image = Image.load_from_file(image_path)
	ally_two_texture = ImageTexture.create_from_image(ally_two_image)
	ally_icon_2.texture = ally_two_texture
	
## function for setting the player's name. input: String
func _set_player_name(name: String):
	player_name.text = name
	
## function for setting the player's name. input: String
func _set_boss_name(name: String):
	boss_name.text = name
