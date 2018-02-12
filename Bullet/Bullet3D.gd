extends Spatial

#private vars
onready var _prev_pos = self.global_transform

func init_inst():
	pass

func _physics_process(delta):
	#increment travel distance if that is a death param
	if kill_after_travel_dist > 0:
		traveled_dist += self.global_transform.distance_to(_prev_pos)
		_prev_pos = self.global_transform