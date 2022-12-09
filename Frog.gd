extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var value = 1
export var speed : int = 5
export var moveDist : int = 20
export var speed2 : int = 10
export var moveDist2 : int = 10
onready var startY : float = position.y
onready var targetY : float = position.y + moveDist2
onready var startX : float = position.x
onready var targetX : float = position.x + moveDist
onready var sprite = $AnimatedSprite
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process (delta):
	position.y = move_to(position.y, targetY, speed2 * delta)
	 # if we're at our target, move in the other direction
	if position.y == targetY:
		if targetY == startY:
			targetY = position.y + moveDist
		else:
			targetY = startY
	
	position.x = move_to(position.x, targetX, speed * delta)
	# if we're at our target, move in the other direction
	if position.x == targetX:
		if targetX == startX:
			targetX = position.x + moveDist
		else:
			targetX = startX
		sprite.play("Jump")
		

func move_to (current, to, step):
	var new = current
	# are we moving positive?
	if new < to:
		new += step
		if new > to:
			new = to
	# are we moving negative?
	else:
		new -= step
		if new < to:
			new = to
	return new



func _on_Frog_body_entered(body):
	if body.name == "Player":
		body.collect_frog(value)
		queue_free()
