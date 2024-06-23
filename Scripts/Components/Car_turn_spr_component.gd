extends Sprite2D

var car_master:car_movement_component

# Called when the node enters the scene tree for the first time.
func _ready():
	car_master = get_parent().get_node("Car_movement_component") as car_movement_component
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(car_master != null):
		frame = frame_r(car_master.angle)
	global_rotation = 0
	
	pass

func frame_r(ang:float):
	if(ang <= 22.5 && ang >= -22.5):
		return 0
	elif(ang < 67.5 && ang > 22.5):
		return 1
	elif(ang <= 112.5 && ang >= 67.5):
		return 2
	elif(ang < 157.5 && ang > 112.5):
		return 3
	elif(ang <= 180 && ang >= 157.5):
		return 4
	elif(ang < -22.5 && ang > -67.5):
		return 7
	elif(ang <= -67.5 && ang >= -112.5):
		return 6
	elif(ang <= -112.5 && ang >= -157.5):
		return 5
	else:
		return 4
