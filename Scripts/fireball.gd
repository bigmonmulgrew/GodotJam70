extends BaseProjectile


func _on_fireball_area_body_entered(body):
	if body != owner:
		explode()
