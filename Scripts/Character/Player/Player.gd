extends CharacterBody2D

# Gets the child of PrimaryAction node with index 0
@onready var primary_action: Node = $PrimaryAction.get_child(0)
# Gets the child of SecondaryAction node with index 0
@onready var secondary_action: Node = $SecondaryAction.get_child(0)
# Gets the child of DefensiveAction node with index 0
@onready var defensive_action: Node = $DefensiveAction.get_child(0)

func _process(delta):
	_check_input()

func _physics_process(delta):
	
	move_and_slide()

func _check_input():
	# Check if primary action is not null
	if primary_action:
		if Input.is_action_just_pressed("primary_action"): primary_action.use()
	# Check if secondary action is not null
	if secondary_action:
		if Input.is_action_just_pressed("secondary_action"): secondary_action.use()
	# Check if defensive action is not null
	if defensive_action:
		if Input.is_action_just_pressed("defensive_action"): defensive_action.use()
	
	
