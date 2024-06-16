extends CharacterBody2D

# Gets the child of PrimaryAction node with index 0
@onready var primary_action: Node2D = $PrimaryAction.get_child(0)
# Gets the child of SecondaryAction node with index 0
@onready var secondary_action: Node2D = $PrimaryAction.get_child(0)

func _process(delta):
	_check_input()

func _physics_process(delta):
	
	move_and_slide()

func _check_input():
	if Input.is_action_just_pressed("primary_action"): primary_action.use()
	if Input.is_action_just_pressed("secondary_action"): secondary_action.use()
