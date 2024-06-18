extends "res://Scripts/Components/Actions/Attacks/attack_base.gd"

#region Object Rederences
## Reference to the animation player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion

func use():
	animation_player.play("tentacle_attack")


func _on_area_2d_body_entered(body):
	var body_health_component = body.get_node("HealthComponent")
	if body_health_component:
		body_health_component.remove_health(damage, damage_type)
