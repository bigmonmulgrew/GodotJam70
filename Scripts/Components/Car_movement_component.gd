extends Node2D
class_name car_movement_component

var angle:float = 0
@export var turn_speed:float = 100

var move_force:float = 0
@export var acceleration_rate = 200
@export var deceleration_rate = 300
@export var move_forward_speed = 400
@export var move_backward_speed = 100

var crash_timer:float = 0

var parent_to_move: CharacterBody2D

var horizontal:float = 0
var vertical:float = 0

@export var carsh_force = 150

var forward_dir:Vector2 = Vector2(0,-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_to_move = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	horizontal = Input.get_axis("move_left","move_right")
	vertical = Input.get_axis( "move_down","move_up")
	print(vertical)
	
	var target_move_speed = move_forward_speed
	if vertical < 0:
		target_move_speed = move_backward_speed
	
	if(vertical != 0 && crash_timer <= 0):
		move_force = move_toward(move_force, target_move_speed*vertical, acceleration_rate*delta)
	else:
		move_force = move_toward(move_force, 0, deceleration_rate*delta)
		
	angle+=horizontal*turn_speed*(1+(move_force/1000))*delta
	
	forward_dir = Vector2(sin(deg_to_rad(angle)),-cos(deg_to_rad(angle)))
	
	
	parent_to_move.global_rotation_degrees = angle
	parent_to_move.velocity = parent_to_move.velocity.move_toward((forward_dir*move_force), 400*delta)
	parent_to_move.up_direction = -forward_dir
	
	if parent_to_move.is_on_floor():
		parent_to_move.velocity += parent_to_move.get_floor_normal()*carsh_force
		crash_timer = 0.25
		
	if crash_timer > 0:
		crash_timer -= delta
		
	if angle > 180:
		angle-=360
	if angle < -180:
		angle+=360
	
	pass
