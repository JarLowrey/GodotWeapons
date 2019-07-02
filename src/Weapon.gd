extends GDWeaponsActionWithCooldown

class_name GDWeaponsWeapon

const WEAPON_PATH_FROM_COMPONENT = ".."

# act as controller/coordinator - get all the paths to other nodes

var MagNamePath = "Magazine"
var magazine

func _ready():
	if has_node(MagNamePath):
		magazine = get_node(MagNamePath)
