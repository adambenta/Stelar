extends Area2D

func _on_body_entered(body):
	queue_free()
	body.add_barry()
