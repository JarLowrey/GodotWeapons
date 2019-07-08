extends GDWeaponsLongAction

class_name GDWeaponsWeapon

const WEAPON_PATH_FROM_COMPONENT = ".."

# act as controller/coordinator - get all the paths to other nodes

var MagPath = "Magazine"
var magazine
var BurstPath = "Magazine"
var burst

func _ready():
	if has_node(MagPath):
		magazine = get_node(MagPath)
	if has_node(BurstPath):
		burst = get_node(BurstPath)

func start_attack():
	.start_action()
	
func end_attack():
	.end_action()
	
func cancel_attack():
	.cancel_action()