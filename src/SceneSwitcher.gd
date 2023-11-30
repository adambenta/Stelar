extends Node

@onready var current_level = $Menu

func _ready():
	current_level.level_changed.connect(handle_level_changed)

func handle_level_changed(current_level_name: String):
	var next_level
	var next_level_name: String

	match current_level_name:
		"Menu":
			next_level_name = "HowToMoove"
		"HowToMoove":
			next_level_name = "HowToMoove"
		_:
			return
	
	next_level = load("res://src/levels/" + next_level_name + ".tscn").instance()
	add_child(next_level)
	current_level.queue_free()
	current_level = next_level
