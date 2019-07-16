extends GDWeaponsLongAction

func _apply_end_action():
	get_node("../MagCapacity").refill()
	._apply_end_action()