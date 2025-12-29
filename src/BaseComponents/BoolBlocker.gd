extends Node

class_name GDWeaponsBoolBlocker

@onready var weapon : GDWeaponsWeapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

var blocked = false: set = _set_blocked
signal blocking_ended

@export var auto_reset = false
@export var block_on_start = false
@export var block_on_end = false

func is_blocked():
	return (block_on_end or block_on_start) and blocked

func _set_blocked(val):
	blocked = val
	
	if auto_reset and not blocked:
		blocked = true
	if not blocked:
		blocking_ended.emit()
