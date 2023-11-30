extends Control

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

func _on_start_button_pressed():
	emit_signal("level_changed", level_name)

func _on_options_button_pressed():
	open_option = !open_option
	if open_option:
		level_parameters.input_menu.visible = true
	else:
		level_parameters.input_menu.visible = false
	get_tree().root.get_viewport().set_input_as_handled()

func _on_quit_button_pressed():
	get_tree().quit()

func _unhandled_input(event):
	if Input.is_action_pressed("ui_cancel"):
		open_option = !open_option
		if open_option:
			level_parameters.input_menu.visible = true
		else:
			level_parameters.input_menu.visible = false
		get_tree().root.get_viewport().set_input_as_handled()

func load_level_parameters(new_level_parameters: Dictionary):
	level_parameters = new_level_parameters
	get_tree().root.get_viewport().set_input_as_handled()
