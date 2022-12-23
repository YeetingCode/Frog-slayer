extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var value = 1
export var speed : int = 10
export var moveDist : int = 10
onready var startY : float = position.y
onready var targetY : float = position.y + moveDist
onready var sprite = $AnimatedSprite
var dead : bool = false
signal ani_fin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process (delta):
	if not dead:
		position.y = move_to(position.y, targetY, speed * delta)
		 # if we're at our target, move in the other direction
		if position.y == targetY:
			if targetY == startY:
				targetY = position.y + moveDist
			else:
				targetY = startY
	
	


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


func _on_AnimatedSprite_animation_finished():
	emit_signal("ani_fin") # Replace with function body.

func _on_Frog_body_entered(body):
	if body.name == "Player":
		body.collect_frog(value)
		dead = true
		sprite.play("Dead")
		yield(self,"ani_fin")
		queue_free()


