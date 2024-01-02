extends Area2D

var lockPortal = false
@export var id: int

func _ready():
	pass

func lockedPortal():
	lockPortal = true
	await get_tree().create_timer(0.5).timeout
	lockPortal = false

func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.teleport(self)
