extends Node2D

const respawn_location_x = 0
const respawn_location_y = 0

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.death()
