extends GDWeaponsLongAction

class_name GDWeaponsCooldownAction

func _ready():
	var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)
	weapon.add_interupting_action(self)
	weapon.connect("ended",self,"start_action")