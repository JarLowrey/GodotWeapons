extends GDWeaponsCapacity

class_name GDWeaponsAmmo

@onready var weapon : GDWeaponsWeapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

signal blocking_ended
var block_on_start = true

func _ready():
	weapon.add_blocker(self)
	weapon.ended.connect(decrement)
	can_decrement_again.connect(blocking_ended.emit)
	refill()

func is_blocked():
	print(current_capacity," ",decrement_step)
	return current_capacity < decrement_step
