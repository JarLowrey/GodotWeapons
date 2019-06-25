extends WeaponComponentParent

var _magazine

func _ready():
	call_deferred("begin_auto_attack")
	connect("tree_exited",self,"end_auto_attack")

	if weapon.has_node("Magazine"):
		_magazine = weapon.get_node("Magazine")
		_magazine.connect("reload_successfully",weapon,"start_action")

func start_auto_attack():
	weapon.connect("")
func end_auto_attack():
	if _magazine != null and _magazine.is_connected("reloaded_successfully",weapon,"start_action"):
		_magazine.connect("reloaded_successfully",weapon,"start_action")

