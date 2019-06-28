extends Sprite

export var speed = 50

func _physics_process(delta):
	var x = cos(global_rotation) * speed
	var y = sin(global_rotation) * speed
	global_position +=  Vector2(x,y)