extends Node2D

## The rate at which the objects fall
@export var gravity: float = 1000

## Array of children in the pool
var children: Array = []

func _ready():
	# Get the children
	children = get_children()

func _physics_process(delta):
	for object in get_children():
		object.global_position.y += gravity * delta
