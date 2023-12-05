extends Area2D

signal level_changed(level_name: String)

var entered = false

func _ready():
	pass

func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			var temp_world = get_parent()
			if temp_world:
				temp_world.change_lvl()
			else:
				print("Error: world node not found")

func _on_body_entered(body: PhysicsBody2D):
	entered = true

func _on_body_exited(body):
	entered = false
