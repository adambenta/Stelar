extends Area2D

var lockPortal = false

func _ready():
	pass

func lockedPortal():
	lockPortal = true
	await get_tree().create_timer(0.5).timeout
	lockPortal = false

func _process(delta):
	pass


func _on_area_entered(area):
	print("test")
	pass # Replace with function body.
