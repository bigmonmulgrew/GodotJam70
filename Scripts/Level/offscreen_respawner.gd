extends Area2D

## Area to reset any objects that collide to the top of the screen

#region Object References
## Gets the viewport width
@onready var viewport_width: int = get_viewport().size.x
#endregion

func _on_body_entered(body):
	if body is Node2D:
		body.global_position.y = -100
		# Set the x to be randomly within the width of the viewport
		body.global_position.x = randi_range(0, viewport_width)


func _on_area_entered(area):
	if area is Node2D:
		area.global_position.y = -100
		# Set the x to be randomly within the width of the viewport
		area.global_position.x = randi_range(0, viewport_width)
