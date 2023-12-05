extends Node

@onready var current_level = $Menu

var open_option = false

var level_parameters := {
	"input_menu": null
}

func _ready():
	current_level.level_changed.connect(handle_level_changed)

func handle_level_changed(current_level_name: String):
	var next_level_name: String

	match current_level_name:
		"Menu":
			next_level_name = "HowToMoove"
		"HowToMoove":
			next_level_name = "Level2"
		"Level2":
			next_level_name = "HowToMoove"
		_:
			return
	var next_level = load("res://src/levels/" + next_level_name + ".tscn").instantiate()
	add_child(next_level)
	transfer_data_between_scenes(next_level)
	current_level.queue_free()
	current_level = next_level
	current_level.level_changed.connect(handle_level_changed)

func transfer_data_between_scenes(new_scene):
	new_scene.load_level_parameters()
