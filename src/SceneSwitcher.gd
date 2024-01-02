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
			MusicController.play_music_cave()
		"HowToMoove":
			next_level_name = "Level1"
		"Level1":
			next_level_name = "Level2"
		"Level2":
			next_level_name = "Level3"
		"Level3":
			next_level_name = "Level4"
		"Level4":
			next_level_name = "Level5"
		"Level5":
			next_level_name = "Level6"
		"Level6":
			next_level_name = "Level7"
		"Level7":
			next_level_name = "Level8"
		"Level8":
			next_level_name = "Level9"
		"Level9":
			next_level_name = "Level1_forest"
			MusicController.stop_music_cave()
			MusicController.play_music_forest()
		"Level1_forest":
			next_level_name = "Level2_forest"
		"Level2_forest":
			next_level_name = "Level1_space"
		"Level2_forest":
			next_level_name = "Level3_forest"
		"Level3_forest":
			next_level_name = "Level4_forest"
		"Level4_forest":
			next_level_name = "Level5_forest"
		"Level5_forest":
			next_level_name = "Level6_forest"
		"Level6_forest":
			next_level_name = "Level7_forest"
		"Level7_forest":
			next_level_name = "Level8_forest"
		"Level8_forest":
			next_level_name = "Level1_space"
		"Level1_space":
			next_level_name = "Level2_space"
		"Level2_space":
			next_level_name = "WIN"
		"WIN":
			next_level_name = "Menu"
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
