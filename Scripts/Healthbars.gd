extends CanvasLayer

var player_max_health: int
var player_current_health: int
var player_current_health_pos: float
@onready var player_bar: TextureProgressBar = $PlayerHealthBar

var player_max_resource: int
var player_current_resource: int
var player_current_resource_pos: float
@onready var resource_bar: TextureProgressBar = $PlayerHealthBar/PlayerResourceBar

var boss_max_health: int
var boss_current_health: int
var boss_current_health_pos: float
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
		player_current_health_pos += 0.02
	if player_current_health < player_current_health_pos:
		player_current_health_pos -= 0.02
		
	#moving resource bar
	if player_current_resource > player_current_health_pos:
		player_current_resource_pos += 0.02
	if player_current_resource < player_current_resource_pos:
		player_current_resource_pos -= 0.02
	
	#moving boss health
	if boss_current_health > boss_current_health_pos:
		boss_current_health_pos += 0.02
	if boss_current_health < boss_current_health_pos:
		boss_current_health_pos -= 0.02
	
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
	
	
