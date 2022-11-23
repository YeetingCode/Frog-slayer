extends KinematicBody2D

const speed = 200
const UP = Vector2(0, -1)
const gravity = 40

var motion = Vector2()

func _ready() -> void:
	motion.x = -speed

func _physics_process(delta: float) -> void:
	motion.y += gravity
	
	if is_on_wall():
		motion.x *= -1.0
	motion.y = move_and_slide(motion, UP).y
	
	
