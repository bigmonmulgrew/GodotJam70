extends Attack

# Get the animation player from the tree
@onready var anim_player: AnimationPlayer = $AnimationPlayer

# Overide for the base use
# Plays the attack
func use():
	anim_player.play("sword_attack")


func _on_area_2d_body_entered(body):
	pass #TODO: Add enemy collision logic
