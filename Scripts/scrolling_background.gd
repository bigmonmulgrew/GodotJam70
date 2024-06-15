extends ParallaxBackground

@export_group("Texture")
## Background texture for scrolling as a CompressedTexture2D
@export var bg_texture: CompressedTexture2D = preload("res://icon.svg")
## Height of the sprite in pixels as an int
@export var bg_height: int = 128

@export_group("Scrolling")
## Scrolling speed of the background as a float
@export var vertical_speed: float = 10
@export var horizontal_speed: float = 10


# Get the sprite
@onready var sprite = $ParallaxLayer/Sprite2D

func _ready():
	sprite.texture = bg_texture
	
func _process(delta):
	# Scroll the background by speed
	sprite.region_rect.position += delta * Vector2(horizontal_speed, -vertical_speed)
	
	# reset the rect pos if it goes outside of height
	if sprite.region_rect.position >= Vector2(bg_height, bg_height):
		sprite.region_rect.position = Vector2.ZERO
	print(sprite.region_rect.position)
