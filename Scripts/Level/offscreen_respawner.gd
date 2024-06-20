extends Area2D

## Area to reset any objects that collide to the top of the screen.
## [br]
## Place the start and end markers to denote the line where objects can respawn

#region Object References
## Starting marker.
@onready var start_marker: Marker2D = $StartMarker
## Ending marker
@onready var end_marker: Marker2D = $EndMarker
#endregion

func _on_body_entered(body):
	if body is Node2D:
		body.global_position.y = start_marker.global_position.y
		# Set the x to be randomly within the width of the viewport
		body.global_position.x = randi_range(start_marker.global_position.x, end_marker.global_position.x)


func _on_area_entered(area):
	if area is Node2D:
		area.global_position.y = start_marker.global_position.y
		# Set the x to be randomly within the width of the viewport
		area.global_position.x = randi_range(start_marker.global_position.x, end_marker.global_position.x)
