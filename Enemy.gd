extends KinematicBody2D

const speed = 200
const UP = Vector2(0, -1)
const gravity = 40

var motion = Vector2()

func _ready():
	motion.x = -speed

func _on_StompDetector_body_entered(body: KinematicBody2D):
	if body.global_position.y < get_node("StompDetector").global_position.y:
		queue_free()




func _physics_process(delta):
	
	
	motion.y += gravity
	
	if is_on_wall():
		motion.x *= -1.0
	motion.y = move_and_slide(motion, UP).y


