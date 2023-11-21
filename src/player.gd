extends CharacterBody2D


const speed = 300.0
const jump_power = -500.0
const double_jump_power = -700
const gravity = 30
var is_left = 1
var max_jump = 1

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D 

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 800:
			velocity.y = 800
		if Input.is_action_just_pressed("ui_up"):
			if max_jump == 1:
				velocity.y = double_jump_power
				max_jump = 0

	elif Input.is_action_just_pressed("ui_up"):
		ap.play("jump")
		velocity.y = jump_power

	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
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
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
			max_jump = 1
		else:
			ap.play("run")
			max_jump = 1
			
func switch_dir(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)
