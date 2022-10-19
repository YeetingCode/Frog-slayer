extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score : int = 0
# physics
var speed : int = 200
var jumpForce : int = 600
var gravity : int = 800
var vel : Vector2 = Vector2()
var grounded : bool = false


onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process (delta):
	# reset horizontal velocity
	vel.x = 0
	# movement inputs
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
	vel = move_and_slide(vel, Vector2.UP)
	# gravity
	vel.y += gravity * delta
	# jump input
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
		yield(get_tree().create_timer(delta),"timeout")
		sprite.play("Jump")
	
	
	# sprite direction
	if vel.x < 0:
		sprite.flip_h = true
		if not sprite.playing:
			sprite.play("Walk")
	elif vel.x > 0:
		sprite.flip_h = false
		if not sprite.playing:
			sprite.play("Walk")
	
	if vel.x == 0 and is_on_floor():
		sprite.play("Idle")
		sprite.stop()


