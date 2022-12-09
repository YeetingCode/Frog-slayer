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
var velprev : Vector2 = Vector2()
var resistance : int = 1
onready var sprite = $Sprite
var walking : bool = false
signal onFloor
# Called when the node enters the scene tree for the first time.
func _ready():
	vel.x = 0
	velprev.x = 0
	sprite.stop()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process (delta):
	# calculate horizontal velocity
	if vel.x < 0 and not is_on_floor():
		vel.x = velprev.x + resistance
		if vel.x > 0:
			vel.x = 0
	elif vel.x > 0 and not is_on_floor():
		vel.x = velprev.x - resistance
		if vel.x < 0:
			vel.x = 0
	else:
		vel.x = 0
	# check if on floor, and emit signal
	if is_on_floor():
		emit_signal("onFloor")
	
	# movement inputs
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
		if vel.x < (0 - speed):
			vel.x = -speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		if vel.x > speed:
			vel.x = speed
	vel = move_and_slide(vel, Vector2.UP)
	# gravity
	vel.y += gravity * delta
	# jump input
	if Input.is_action_pressed("jump") and is_on_floor():
		yield(get_tree().create_timer(delta),"timeout")
		vel.y -= jumpForce
		if vel.y <= -jumpForce:
			vel.y = -jumpForce
		sprite.play("Jump")
		yield(self,"onFloor")
		if walking == true:
			sprite.play("Walk")
		else:
			sprite.play("Idle")
			sprite.stop()
	
	
	# sprite direction
	if vel.x < 0:
		sprite.flip_h = true
		if not sprite.playing:
			sprite.play("Walk")
			walking = true
	elif vel.x > 0:
		sprite.flip_h = false
		if not sprite.playing:
			sprite.play("Walk")
			walking = true
	
	# more sprite animation
	if vel.x == 0 and is_on_floor():
		sprite.play("Idle")
		sprite.stop()
	
	if not is_on_floor() and not sprite.playing:
		sprite.play("Jump")
		yield(self,"onFloor")
		if walking == true:
			sprite.play("Walk")
		else:
			sprite.play("Idle")
			sprite.stop()

	
	# variable to use in the next delta
	if vel.x == 0:
		walking = false
	
	velprev.x = vel.x

func collect_frog (value):
	score += value

func die ():
	get_tree().reload_current_scene()
