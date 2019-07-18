extends GDWeaponsCapacity

class_name GDWeaponsMagCapacity

signal ended()

func can_start_action():
	return current_capacity >= step
	
func set_curr_capacity(val):
	.set_curr_capacity(val)
	emit_signal("ended")