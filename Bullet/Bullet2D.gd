extends 'res://Bullet/Bullet.gd'

#private vars
onready var _prev_pos = self.global_position
var speed = 1500
var _vel = Vector2()

func init_inst():
	self.global_rotation = my_muzzle.global_rotation
	self.global_position = my_muzzle.global_position
	_vel = Vector2(speed,0).rotated(self.global_rotation)

func _physics_process(delta):
	move(delta)
	
	#increment travel distance if that is a death param
	if kill_after_travel_dist > 0:
		traveled_dist += self.global_position.distance_to(_prev_pos)
		_prev_pos = self.global_position

func move(delta): #override if you want different movement type
	self.global_position += _vel * delta