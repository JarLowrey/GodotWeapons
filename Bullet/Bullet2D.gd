extends 'res://Bullet/Bullet.gd'

#private vars
onready var _prev_pos = self.global_position

func init(dir,pos):
	.init(dir,pos)
	self.global_rotation = dir
	self.global_position = pos

func _physics_process(delta):
	#increment travel distance if that is a death param
	if kill_after_travel_dist > 0:
		traveled_dist += self.global_position.distance_to(_prev_pos)
		_prev_pos = self.global_position