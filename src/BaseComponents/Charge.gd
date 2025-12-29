extends GDWeaponsCapacity

class_name GDWeaponsCharge

@onready var weapon : GDWeaponsWeapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

signal blocking_ended
var block_on_start = true

func _ready():
	weapon.add_blocker(self)
	weapon.ended.connect(empty)
	filled.connect(blocking_ended.emit)

func is_blocked():
	return current_capacity != max_capacity
