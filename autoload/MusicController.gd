extends Node

@onready var cave_music = $AudioStreamPlayer
@onready var forest_music = $AudioStreamPlayer2
@onready var space_music = $AudioStreamPlayer3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_music_forest():
	forest_music.play()
	
func stop_music_forest():
	forest_music.stop()

func play_music_cave():
	cave_music.play()

func stop_music_cave():
	cave_music.stop()
	
func play_music_space():
	space_music.play()

func stop_music_space():
	space_music.stop()
