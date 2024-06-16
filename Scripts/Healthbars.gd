extends CanvasLayer

## The players maximum health 
var player_max_health: int
## The players current health
var player_current_health: int
## The target position of the players healthbar
var player_current_health_pos: float
## The movement scale of the healthbar
var player_bar_rate: float = 0.02
@onready var player_bar: TextureProgressBar = $PlayerHealthBar

## The players maximum resource
var player_max_resource: int
## The players current resource
var player_current_resource: int
## The target position of the players resource bar
var player_current_resource_pos: float
## The movement scale of the resource bar
var player_resource_rate: float = 0.02
@onready var resource_bar: TextureProgressBar = $PlayerHealthBar/PlayerResourceBar

## The bosses maximum health
var boss_max_health: int
## The bosses current health
var boss_current_health: int
## The target position of the bosses healthbar
var boss_current_health_pos: float
## The movement scale of the bosses healthbar
var boss_bar_rate: float = 0.02
@onready var boss_bar: TextureProgressBar = $BossHealthBar

var ally_one_max_health: int
var ally_one_current_health: int
@onready var ally_health_bar_1 = $PlayerHealthBar/AllyHealthBar1


var ally_two_max_health: int
var ally_two_current_health: int
@onready var ally_health_bar_2 = $PlayerHealthBar/AllyHealthBar2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	player_bar.texture_progress.speed_scale = player_max_health - player_current_health_pos
	boss_bar.texture_progress.speed_scale = boss_max_health - boss_current_health_pos
	resource_bar.texture_progress.speed_scale = player_max_resource - player_current_resource_pos
	
	#updating bars
	player_bar.value = player_current_health_pos
	boss_bar.value = boss_current_health_pos
	resource_bar.value = player_current_resource_pos
	ally_health_bar_1.value = ally_one_current_health
	ally_health_bar_2.value = ally_two_current_health
	
	
