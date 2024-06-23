extends ParallaxBackground

@export_group("Texture")
## Background texture for scrolling as a CompressedTexture2D
@export var bg_texture: CompressedTexture2D = preload("res://icon.svg")


@export_group("Scrolling")
## Scrolling speed of the background as a float
@export var vertical_speed: float = 10
@export var horizontal_speed: float = 10


# Get the sprite
@onready var sprite = $ParallaxLayer/Sprite2D
@onready var parallax_layer = $ParallaxLayer

## Height of the sprite in pixels as an int
var bg_height: int = 0
var bg_width: int = 0

func _ready():
	sprite.texture = bg_texture
	bg_height = bg_texture.get_height()
	bg_width = bg_texture.get_width()
	parallax_layer.motion_mirroring = Vector2(bg_width, bg_height)
	
func _process(delta):
	debug()
	# Scroll the background by speed
	sprite.region_rect.position += delta * Vector2(horizontal_speed, -vertical_speed)
	
	# reset the rect pos if it goes outside of height
	if sprite.region_rect.position.x >= bg_width or sprite.region_rect.position.x <= -bg_width:
		sprite.region_rect.position = Vector2.ZERO
	elif sprite.region_rect.position.y >= bg_height or sprite.region_rect.position.y <= -bg_height:
		sprite.region_rect.position = Vector2.ZERO

func debug():
	#TODO remove on production
	if(Input.is_action_just_pressed("debug_win")):
		SaveSystem.save_data(0,"RiverCascade", true)
		LevelMaster.load_level("Menus/character_select.tscn")
