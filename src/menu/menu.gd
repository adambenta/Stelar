extends Control

@onready var input_menu = $GUI/InputSettings

var open_option = false

signal level_changed(level_name)

@export var level_name: String = "level"

func _ready():
	pass

func _process(delta):
	pass

func _on_start_button_pressed():
	emit_signal("level_changed", level_name)

func _on_options_button_pressed():
	open_option = !open_option
	if open_option:
		input_menu.visible = true
	else:
		input_menu.visible = false
	get_tree().root.get_viewport().set_input_as_handled()

func _on_quit_button_pressed():
	get_tree().quit()

func _unhandled_input(event):
	if Input.is_action_pressed("ui_cancel"):
		open_option = !open_option
		if open_option:
			input_menu.visible = true
		else:
			input_menu.visible = false
		get_tree().root.get_viewport().set_input_as_handled()

func _transfer_data_between_scenes(old_scene, new_scene):
	new_scene.input_menu = old_scene.input_menu 
