extends GDWeaponsCapacity

class_name GDWeaponsAmmo

onready var weapon = get_node("..")

signal ended()

func _ready():
	weapon.add_action_to_interupt_start(self)
	weapon.connect("ended",self,"decrement")
#	connect("not_enough_capacity",self,"turn_off_ability_to_act")
	
func can_start_action():
	return current_capacity >= step


func set_curr_capacity(val):
	.set_curr_capacity(val)
	emit_signal("ended")