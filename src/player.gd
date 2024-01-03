extends CharacterBody2D

const speed = 300.0
const dash_speed = 1500.0
const dash_speed_vertical = 1500.0
const jump_power = -500.0
const double_jump_power = -700
const gravity = 30
const wall_slide_gravity = 0
const cloud_jump_var = -600
var is_left = 1
var max_jump = 1
var is_dying = false
var wall_jump_power = 10000
var wall_slide_var = false
var can_dash = true
var is_dashing = false
var cancel_dash = false
var barry = 0

var portal_id = 0
var start_pos = Vector2(position.x, position.y)

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var dash_timer = $Timer

func _physics_process(delta):
	if is_dying:
		return
	if !is_on_floor():
		if wall_slide_var:
			wall_gravity()
		else:
			velocity.y += gravity
		if velocity.y > 1500:
			velocity.y = 1500
		if !wall_slide_var and Input.is_action_just_pressed("jump"):
			if max_jump == 1:
				velocity.y = double_jump_power
				ap.play("double_jump")
				max_jump = 0
		if is_on_wall() and Input.is_action_just_pressed("move_left"):
			velocity.y = jump_power
			velocity.x = -400
		if is_on_wall() and Input.is_action_just_pressed("move_right"):
			velocity.y = jump_power
			velocity.x = 400

	elif Input.is_action_just_pressed("jump"):
		ap.play("jump")
		velocity.y = jump_power

	var horizontal_direction = Input.get_axis("move_left", "move_right")
	var vertical_direction = Input.get_axis("jump", "down")
	if Input.is_action_just_pressed("dash") and can_dash:
		is_dashing = true
		can_dash = false
		dash_timer.start()
	if is_dashing:
		dash(horizontal_direction, vertical_direction)
	else:
		velocity.x = speed * horizontal_direction
	if cancel_dash:
		cancel_dash = false
		velocity.y = 0
	
	if horizontal_direction == -1 && is_left != 0:
		sprite.position.x -= 45
		is_left = 0
	elif horizontal_direction == 1 && is_left == 0:
		sprite.position.x += 45
		is_left = 1
	
	if horizontal_direction != 0:
		switch_dir(horizontal_direction)

	move_and_slide()
	update_animation(horizontal_direction)
	wall_slide(delta)
	
func update_animation(horizontal_direction):
	if is_dying:
		return
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
			max_jump = 1
			can_dash = true
		else:
			ap.play("run")
			max_jump = 1
			can_dash = true

func switch_dir(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)

func death():
	ap.play("Death")
	is_dying = true
	await get_tree().create_timer(1).timeout
	is_dying = false
	position.x = start_pos.x
	position.y = start_pos.y

func cloud_jump():
	velocity.y = cloud_jump_var
	max_jump = 1
	can_dash = true
	ap.play("jump")

func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("grab"):
			max_jump = 1
			wall_slide_var = true
		else:
			wall_slide_var = false
	else:
		wall_slide_var = false

func wall_gravity():
	velocity.y = 0
	if Input.is_action_pressed("jump"):
		position.y -= 4
	if Input.is_action_pressed("down"):
		position.y -= -4

func dash(horizontal_direction, vertical_direction):
	velocity.x = horizontal_direction * dash_speed
	velocity.y = vertical_direction * dash_speed

func add_barry():
	Global.score += 1

func _on_timer_timeout():
	is_dashing = false
	dash_timer.stop()
	cancel_dash = true

func teleport(area):
	for portal in get_tree().get_nodes_in_group("portal"):
		if portal != area:
			if portal.id == area.id:
				if !portal.lockPortal:
					area.lockedPortal()
					self.position = portal.position
					velocity.y = 0
