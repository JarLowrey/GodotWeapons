extends GDWeaponsLongAction

class_name GDWeaponsCooldownAction

func _ready():
	var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)
	weapon.add_action_to_interupt_start(self)
	weapon.connect("ended",self,"start_action")
	
func start_action():
	.start_action()
func end_action():
	.end_action()
func cancel_action():
	.cancel_action()