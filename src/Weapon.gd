extends GDWeaponsLongAction

class_name GDWeaponsWeapon

const WEAPON_PATH_FROM_COMPONENT = ".."

# act as controller/coordinator - get all the paths to other nodes

onready var charge = get_node("Charge") if has_node("Charge") else null
onready var burst = get_node("Burst") if has_node("Burst") else null
onready var magazine = get_node("Magazine") if has_node("Magazine") else null

func start_attack():
	print(can_start_action())
	.start_action()
	
func end_attack():
	print("attack ended")
	.end_action()
	
func cancel_attack():
	.cancel_action()