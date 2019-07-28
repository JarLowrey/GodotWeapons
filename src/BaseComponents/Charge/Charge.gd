extends GDWeaponsCapacity

class_name GDWeaponsCharge

onready var weapon = get_node("..")

signal ended()

func _ready():
	weapon.add_action_to_interupt_start(self)
	weapon.connect("ended",self,"_reset_charge") #empty charge upon firing

func _reset_charge():
	current_capacity = 0

func can_start_action():
	return current_capacity == max_capacity

func set_curr_capacity(val):
	.set_curr_capacity(val)
	emit_signal("ended")