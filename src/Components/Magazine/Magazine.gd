extends GDWeaponsLongAction

class_name GDWeaponsMagazine

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

signal emptied()
signal decremented(amt_left)

export var size = 1
export var auto_reload = true 
var _attacks_left_in_mag = 1 

func can_start_action():
	return .can_start_action() and _attacks_left_in_mag > 0

func _ready():
	._ready()
	_attacks_left_in_mag = size
	weapon.add_action_to_interupt_start(self)
	weapon.connect("ended",self,"_decrement")

func _decrement():
	if _attacks_left_in_mag > 0:
		_attacks_left_in_mag-=1
		emit_signal("decremented",_attacks_left_in_mag)
		if _attacks_left_in_mag == 0:
			emit_signal("emptied")
			if auto_reload:
				start_reload()

#wrap parent functions for better names and extra get/set logic
func start_reload():
	#if user reloads during attack cooldown, stop attack cooldown
	weapon.cancel_attack() 
	.start_action()

func cancel_reload():
	.cancel_action()

func end_reload():
	_attacks_left_in_mag = size
	.end_action()
