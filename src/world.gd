extends Node2D

@onready var input_menu = $GUI/InputSettings
var open_option = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if Input.is_action_pressed("ui_cancel"):
		open_option = !open_option
		if open_option:
			input_menu.visible = true
		else:
			input_menu.visible = false
		get_tree().root.get_viewport().set_input_as_handled()
