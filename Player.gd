extends KinematicBody2D

const speed = 400
const gravity = 40
const jump = -1000
const UP = Vector2(0, -1)

var motion = Vector2()

var is_jump_cancelled = Input.is_action_just_released("ui_up") and motion.y < 0.0

func _physics_process(delta):
	motion.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
	
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
	
	else:
		motion.x = 0
	
	if is_on_floor():
		Input.get_action_strength("ui_up")
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump
	
	if is_jump_cancelled == true:
		motion.y = gravity
	
	motion = move_and_slide(motion, UP)
