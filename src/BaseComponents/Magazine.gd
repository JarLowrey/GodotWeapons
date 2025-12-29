extends Node

class_name GDWeaponsMagazine

@export var auto_reload = true: set = set_auto_reload
@export var reload_action : GDWeaponsLongAction
@export var mag_capacity : GDWeaponsCapacity

@onready var weapon : GDWeaponsWeapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

signal blocking_ended
var block_on_start = true

func _ready():
	weapon.add_blocker(self)
	
	weapon.ended.connect(mag_capacity.decrement)
	
	#set up component signals
	reload_action.ended.connect(mag_capacity.refill)
	
	#set up blocking ended
	reload_action.ended.connect(trigger_blocker_ended)
	mag_capacity.can_decrement_again.connect(trigger_blocker_ended)

func is_blocked():
	return reload_action.is_acting or not mag_capacity.can_decrement_again

func trigger_blocker_ended():
	if not is_blocked():
		blocking_ended.emit()

func set_auto_reload(val):
	auto_reload = val
	var was_auto_cnt = mag_capacity.emptied.is_connected(reload_action.start_action)
	if auto_reload and not was_auto_cnt:
		mag_capacity.emptied.connect(reload_action.start_action)
	elif not auto_reload and was_auto_cnt:
		mag_capacity.emptied.disconnect(reload_action.start_action)
