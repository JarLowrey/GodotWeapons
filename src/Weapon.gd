extends GDWeaponsLongAction

class_name GDWeaponsWeapon

const WEAPON_PATH_FROM_COMPONENT = ".."

# act as controller/coordinator

func _ready():
	add_action_to_interupt_start($FiringCooldown)

func start_attack():
	.start_action()
	
func end_attack():
	.end_action()
	
func cancel_attack():
	.cancel_action()