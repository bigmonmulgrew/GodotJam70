extends Node2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@export var damage: int = 10

func _process(delta):
	if Input.is_action_just_pressed("left_mouse_button"): _attack()
	
	
func _attack():
	anim_player.play("sword_attack")


func _on_area_2d_body_entered(body):
	pass #TODO: Add enemy collision logic
