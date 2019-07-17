extends  GDWeaponsBoolBlocker

class_name GDWeaponsStartBlocker

onready var weapon = get_node("..")

var can_start = false setget _set_can_start
export var try_start_attack_after_set = false

signal ended()

func _ready():
	weapon.add_action_to_interupt_start(self)
	_set_can_start(can_start)

func can_start_action():
	return can_start
	
func _set_can_start(val):
	can_start = val
	emit_signal("ended")
	if try_start_attack_after_set and can_start:
		weapon.start_attack()
	if auto_reset and can_start:
		call_deferred("flip")

func flip():
	_set_can_start(not can_start)