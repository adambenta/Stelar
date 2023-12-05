extends Area2D

func _ready():
	pass

func _process(delta):
	if entered == true:
		if (Input.is_action_just_pressed("ui_accept")):
			emit_signal("level_changed", "HowToMoove")

var entered = false

func _on_body_entered(body: PhysicsBody2D):
	entered = true


func _on_body_exited(body):
	entered = false
