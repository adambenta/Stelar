extends Control
const Player = preload("./player.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	var player_instance = Player.new()
	player_instance._ready()
	add_child(player_instance)
	player_instance.start_player()
	pass


func _on_options_button_pressed():
	pass


func _on_quit_button_pressed():
	get_tree().quit()
	pass
