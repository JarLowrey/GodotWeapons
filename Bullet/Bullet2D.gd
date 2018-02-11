extends 'res://Bullet/Bullet.gd'

#private vars
onready var _prev_pos = self.global_position

func _on_ready():
	self.global_rotation = my_muzzle.global_rotation
	self.global_position= my_muzzle.global_position

func _physics_process(delta):
	#increment travel distance if that is a death param
	if kill_after_travel_dist > 0:
		traveled_dist += self.global_position.distance_to(_prev_pos)
		_prev_pos = self.global_position