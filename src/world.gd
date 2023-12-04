extends Node2D

var level_parameters := {
	"input_menu": null
}

var open_option = false

signal level_changed(level_name)

@export var level_name: String = "level"

func _ready():
	level_parameters.input_menu = $GUI/InputSettings

func _process(delta):
	pass

func _unhandled_input(event):
	if Input.is_action_pressed("ui_cancel"):
		open_option = !open_option
		if open_option:
			level_parameters.input_menu.visible = true
		else:
			level_parameters.input_menu.visible = false
		get_tree().root.get_viewport().set_input_as_handled()

func load_level_parameters():
	get_tree().root.get_viewport().set_input_as_handled()
