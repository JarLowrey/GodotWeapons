extends GDWeaponsBoolBlocker

class_name GDWeaponsEndBlocker

onready var weapon = get_node("..")

var can_end = false setget _set_can_end
export var try_end_attack_after_set = false

signal ended()

func _ready():
	weapon.add_action_to_interupt_end(self)
	_set_can_end(can_end)

func can_end_action():
	return can_end

func flip():
	_set_can_end(not can_end)
	
func _set_can_end(val):
	can_end = val
	emit_signal("ended")
	
	if try_end_attack_after_set and can_end:
		weapon.end_attack()
	
	if auto_reset and can_end:
		call_deferred("flip")