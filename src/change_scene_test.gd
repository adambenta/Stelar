extends Area2D

signal level_changed(level_name: String)

var entered = false

func _ready():
	pass

func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			var world = get_node("/root/world")
			if world:
				var current_level_name = world.level_name
				print("Signal emitted with level name:", current_level_name)
				emit_signal("level_changed", current_level_name)
			else:
				print("Error: World node not found")

func _on_body_entered(body: PhysicsBody2D):
	entered = true

func _on_body_exited(body):
	entered = false
