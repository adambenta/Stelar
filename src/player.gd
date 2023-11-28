extends CharacterBody2D

const speed = 300.0
const jump_power = -500.0
const double_jump_power = -700
const gravity = 30
var is_left = 1
var max_jump = 1
var is_dying = false

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var input_menu = $GUI/InputSettings

var open_option = false

func _physics_process(delta):
	if is_dying:
		return
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 800:
			velocity.y = 800
		if Input.is_action_just_pressed("jump"):
			if max_jump == 1:
				velocity.y = double_jump_power
				max_jump = 0

	elif Input.is_action_just_pressed("jump"):
		ap.play("jump")
		velocity.y = jump_power

	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	
	if horizontal_direction == -1 && is_left != 0:
		sprite.position.x -= 45
		is_left = 0
	elif horizontal_direction == 1 && is_left == 0:
		sprite.position.x += 45
		is_left = 1
	
	if horizontal_direction != 0:
		switch_dir(horizontal_direction)

	velocity.x = speed * horizontal_direction
	move_and_slide()
	update_animation(horizontal_direction)
	
func update_animation(horizontal_direction):
	if is_dying:
		return
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
			max_jump = 1
		else:
			ap.play("run")
			max_jump = 1
			
func switch_dir(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)

func death():
	ap.play("Death")
	is_dying = true
	await get_tree().create_timer(1).timeout
	is_dying = false
	position.x = 0
	position.y = 0

func _unhandled_input(event):
	if Input.is_action_pressed("ui_cancel"):
		open_option = !open_option
		if open_option:
			input_menu.visible = true
		else:
			input_menu.visible = false
		get_tree().root.get_viewport().set_input_as_handled()
