extends GDWeaponsLongAction

class_name GDWeaponsMagazine

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

signal emptied()
signal decremented(amt_left)

export var size = 1
export var auto_reload = true 
export var reload_cooldown = 3.0
var _attacks_left_in_mag = 1 

func _ready():
	._ready()
	_attacks_left_in_mag = size
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
	weapon.cooldown_delay = reload_cooldown
	.start_action()

func cancel_reload():
	.cancel_action()
	_reset_weapon_delay()

func end_reload():
	.end_action()
	_attacks_left_in_mag = size
	_reset_weapon_delay()

func _reset_weapon_delay():
	print(weapon.original_cooldown_delay)
	weapon.cooldown_delay = weapon.original_cooldown_delay