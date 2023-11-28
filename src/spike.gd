extends Node2D

const respawn_location_x = 0
const respawn_location_y = 0

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.death()
#		await get_tree().create_timer(1).timeout
#		body.position.x = respawn_location_x
#		body.position.y = respawn_location_y
