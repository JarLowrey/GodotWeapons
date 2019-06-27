extends WeaponComponentParent

func _ready():
	call_deferred("begin_auto_attack")
	connect("tree_exited",self,"end_auto_attack")

	start_auto_attack()

func start_auto_attack():
	if not weapon.is_connected("end_action",weapon,"start_action"):
		weapon.connect("end_action",weapon,"start_action")

	if _magazine != null and not _magazine.is_connected("reloaded_successfully",weapon,"start_action"):
		_magazine.connect("reloaded_successfully",weapon,"start_action")

	weapon.start_action()

func end_auto_attack():
	if weapon.is_connected("end_action",weapon,"start_action"):
		weapon.disconnect("end_action",weapon,"start_action")

	if _magazine != null and _magazine.is_connected("reloaded_successfully",weapon,"start_action"):
		_magazine.disconnect("reloaded_successfully",weapon,"start_action")

