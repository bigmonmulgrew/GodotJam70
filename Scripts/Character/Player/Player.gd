extends CharacterBody2D

@onready var primary_action: Node2D = $PrimaryAction.get_child(0)
@onready var secondary_action: Node2D = $PrimaryAction.get_child(0)

func _physics_process(delta):
	
	move_and_slide()
